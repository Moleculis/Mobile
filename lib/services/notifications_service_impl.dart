import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/services/apis/notifications_service.dart';
import 'package:moleculis/utils/firebase_utils.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/pagination/firebase_pagination.dart';
import 'package:moleculis/utils/pagination/pagination_common.dart';
import 'package:moleculis/utils/values/collections_refs.dart';
import 'package:moleculis/utils/values/constants.dart';

class NotificationsServiceImpl extends NotificationsService {
  final FirebasePagination<NotificationModel> _firebasePagination =
  FirebasePagination(dataLimit: Constants.notificationsLimit);

  @override
  Stream<PaginationData<NotificationModel>> loadNotifications({
    bool isLoadMore = false,
  }) {
    final currentUserUsername = locator<AuthBloc>().state.currentUser!.username;

    return _firebasePagination.loadData(
      query: notificationsCollection
          .where('receiverUsername', isEqualTo: currentUserUsername)
          .orderBy('createdAt', descending: true),
      isLoadMore: isLoadMore,
      mapSnapshot: (querySnapshot) =>
          querySnapshot.docs
              .map((documentSnapshot) =>
              NotificationModel.fromJson(
                  documentSnapshot.data() as Map<String, dynamic>)
                  .copyWith(id: documentSnapshot.id))
              .toList(),
      dataItemsEqual: (a, b) =>
      a.id == b.id &&
          a.text == b.text &&
          a.creatorUsername == b.creatorUsername,
    );
  }

  @override
  Stream<List<NotificationModel>> loadUnreadNotifications() {
    final currentUserUsername = locator<AuthBloc>().state.currentUser!.username;
    return notificationsCollection
        .where('receiverUsername', isEqualTo: currentUserUsername)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (querySnapshot) {
        return querySnapshot.docs
            .map((documentSnapshot) =>
            NotificationModel.fromJson(documentSnapshot.data())
                .copyWith(id: documentSnapshot.id))
            .toList();
      },
    );
  }

  @override
  Future<void> createNotification(NotificationModel notification) async {
    final notificationDocRef = notificationsCollection.doc();

    await notificationDocRef.set(
      notification.copyWith(id: notificationDocRef.id).toJson(),
    );
  }

  @override
  Future<void> readNotification({
    required String notificationId,
  }) async {
    await notificationsCollection.doc(notificationId).update({'isRead': true});
  }

  @override
  Future<void> readNotifications({
    required List<NotificationModel> notifications,
  }) async {
    final List<DocumentReference> notificationsDocs = notifications
        .map((notification) => notificationsCollection.doc(notification.id))
        .toList();

    await FirebaseUtils.batchUpdate(
      notificationsDocs,
      data: {'isRead': true},
    );
  }

  @override
  Future<void> deleteNotification({required String notificationId}) async {
    await notificationsCollection.doc(notificationId).delete();
  }

  Future<void> deleteNotifications({
    required List<NotificationModel> notifications,
  }) async {
    final batch = FirebaseFirestore.instance.batch();
    for (final notification in notifications) {
      batch.delete(notificationsCollection.doc(notification.id));
    }
    await batch.commit();
  }
}
