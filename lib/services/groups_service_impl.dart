import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/models/enums/notification_type.dart';
import 'package:moleculis/models/notification/notification_model.dart';
import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_group_request.dart';
import 'package:moleculis/services/apis/groups_service.dart';
import 'package:moleculis/services/apis/notifications_service.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/utils/chat_utils.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/values/collections_refs.dart';

class GroupsServiceImpl implements GroupsService {
  final HttpHelper _httpHelper = locator<HttpHelper>();

  String get _endpointBase => '/groups';

  String get _createGroupEndpoint => _endpointBase + '/';

  String _getGroupsPageEndpoint(int page) => _endpointBase + '/page/$page';

  String _getOtherGroupsPageEndpoint(int page) =>
      _endpointBase + '/other/page/$page';

  String _updateGroupEndpoint(int? groupId) => _endpointBase + '/$groupId';

  @override
  Future<Page> getGroupsPage(int page) async {
    final response = await _httpHelper.get(_getGroupsPageEndpoint(page));
    return Page.fromMap(response);
  }

  @override
  Future<Page> getOtherGroupsPage(int page) async {
    final response = await _httpHelper.get(_getOtherGroupsPageEndpoint(page));
    return Page.fromMap(response);
  }

  @override
  Future<String?> createGroup(CreateUpdateGroupRequest request) async {
    final response = await _httpHelper.post(
      _createGroupEndpoint,
      body: request.toMap(),
    );
    final userUsername = locator<AuthBloc>().state.currentUser!.username;
    final notifications = request.usersUsernames!.map((userName) {
      return NotificationModel(
        id: '',
        creatorUsername: userUsername,
        receiverUsername: userName,
        title: 'New group',
        text: "You've been invited to a new group: ${request.title}",
        notificationType: NotificationType.newGroup,
        createdAt: DateTime.now(),
      );
    }).toList();
    notifications
        .removeWhere((element) => element.receiverUsername == userUsername);
    await locator<NotificationsService>().createNotifications(notifications);
    return response['message'];
  }

  @override
  Future<String?> updateGroup(int groupId,
      CreateUpdateGroupRequest request,) async {
    final response = await _httpHelper.put(
      _updateGroupEndpoint(groupId),
      body: request.toMap(),
    );

    final newMembers = [...request.admins!, ...request.usersUsernames!];

    await firestore.runTransaction((t) async {
      final chatRef = chatsCollection.doc(ChatUtils.getGroupChatId(groupId));
      final chatDoc = await t.get(chatRef);
      if (!chatDoc.exists) return;

      t.update(chatRef, {
        'usersUsernames': newMembers,
      });
    });

    return response['message'];
  }
}
