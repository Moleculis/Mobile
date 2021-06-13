import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/models/user/user_model.dart';
import 'package:moleculis/services/apis/user_service.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/values/collections_refs.dart';
import 'package:moleculis/utils/values/constants.dart';

class UserServiceImpl implements UserService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final HttpHelper _httpHelper = locator<HttpHelper>();

  final String _endpointBase = '/users';

  String get _currentUserEndpoint => _endpointBase + '/current';

  String get _usersEndpoint => _endpointBase + '/';

  String get _otherUsersEndpoint => _endpointBase + '/other';

  String _sendContactRequestEndpoint(String? username) =>
      _endpointBase + '/send_contact_request/$username';

  String _deleteContactEndpoint(int id) =>
      _endpointBase + '/delete_contact/$id';

  String _acceptContactEndpoint(int id) =>
      _endpointBase + '/accept_contact_request/$id';

  @override
  Future<User> getCurrentUser() async {
    final Map<String, dynamic> response =
        await _httpHelper.get(_currentUserEndpoint);
    final User currentUser = User.fromMap(response);
    final currentUserContacts = currentUser.contacts;
    final currentUserContactsRequests = currentUser.contactRequests;
    List<UserModel> contactsModels;
    List<UserModel> contactsRequestsModels;
    if (currentUserContacts != null && currentUserContacts.isNotEmpty) {
      contactsModels = await getUsersModels(
          currentUserContacts.map((e) => e.user.username).toList());
      for (final model in contactsModels) {
        final contactIndex = currentUserContacts
            .indexWhere((element) => element.user.username == model.username);

        currentUserContacts[contactIndex] =
            currentUserContacts[contactIndex].copyWith(userModel: model);
      }
    }
    if (currentUserContactsRequests != null &&
        currentUserContactsRequests.isNotEmpty) {
      contactsRequestsModels = await getUsersModels(
          currentUserContactsRequests.map((e) => e.user.username).toList());
      for (final model in contactsRequestsModels) {
        final contactIndex = currentUserContactsRequests
            .indexWhere((element) => element.user.username == model.username);

        currentUserContactsRequests[contactIndex] =
            currentUserContactsRequests[contactIndex]
                .copyWith(userModel: model);
      }
    }

    return currentUser.copyWith(
      contacts: currentUserContacts,
      contactRequests: currentUserContactsRequests,
    );
  }

  @override
  Stream<UserModel?> currentUserModelStream([String? username]) {
    final currentUserUsername =
        username ?? locator<AuthBloc>().state.currentUser!.username;
    return usersCollection.doc(currentUserUsername).snapshots().map((event) {
      if (!event.exists) return null;
      final userModel = UserModel.fromJson(event.data()!);
      return userModel;
    });
  }

  Future<void> updateUserDeviceToken(UserModel user) async {
    final List<String> existingInFirestoreTokens = user.tokens ?? <String>[];
    final currentToken = await _firebaseMessaging.getToken();
    if (currentToken != null) {
      if (!existingInFirestoreTokens.contains(currentToken)) {
        existingInFirestoreTokens.add(currentToken);
        await usersCollection
            .doc(user.username)
            .update({'tokens': existingInFirestoreTokens});
      }
    }
  }

  @override
  Future<List<UserModel>> getUsersModels(List<String> usersUsernames) async {
    return (await usersCollection
            .where('username', whereIn: usersUsernames)
            .get())
        .docs
        .map((e) {
      return UserModel.fromJson(e.data());
    }).toList();
  }

  @override
  Future<UserModel> getUserModel(String username) async {
    return UserModel.fromJson(
        (await usersCollection.doc(username).get()).data()!);
  }

  @override
  Future<void> deleteCurrentUserDeviceToken() async {
    final user = locator<AuthBloc>().state.currentUserModel;
    if (user == null) return;
    final existTokens = user.tokens!;
    final newToken = await _firebaseMessaging.getToken();
    if (existTokens.contains(newToken)) {
      existTokens.remove(newToken);
    } else {
      return;
    }
    await usersCollection.doc(user.username).update({'tokens': existTokens});
  }

  Future<void> createUserModel() async {
    final currentUser = locator<AuthBloc>().state.currentUser!;
    await usersCollection
        .doc(currentUser.username)
        .set(UserModel(username: currentUser.username).toJson());
  }

  @override
  Future<String?> updateUser(UpdateUserRequest request) async {
    final Map<String, dynamic> response = await _httpHelper.put(
      _currentUserEndpoint,
      body: request.toMap(),
    );
    if (request.newAvatar != null) {
      final userUsername = locator<AuthBloc>().state.currentUser!.username;
      final url = await _uploadAvatar(request.newAvatar!);
      await usersCollection.doc(userUsername).update({'imageUrl': url});
    }
    return response['message'];
  }

  @override
  Future<String?> sendContactRequest(String? username) async {
    final Map<String, dynamic> response = await _httpHelper.post(
      _sendContactRequestEndpoint(username),
    );
    return response['message'];
  }

  @override
  Future<String?> deleteContact(int id) async {
    final Map<String, dynamic> response = await _httpHelper.delete(
      _deleteContactEndpoint(id),
    );
    return response['message'];
  }

  @override
  Future<String?> acceptContact(int id) async {
    final Map<String, dynamic> response = await _httpHelper.post(
      _acceptContactEndpoint(id),
    );
    return response['message'];
  }

  @override
  Future<List<User>> getUsers() async {
    final List<dynamic> response = await _httpHelper.get(_usersEndpoint);
    final List<User> users = response.map((e) => User.fromMap(e)).toList();
    return users;
  }

  @override
  Future<List<User>> getOtherUsers() async {
    final List<dynamic> response = await _httpHelper.get(_otherUsersEndpoint);
    final List<User> users = response.map((e) => User.fromMap(e)).toList();
    return users;
  }

  Future<String> _uploadAvatar(
    File file,
  ) async {
    final userUsername = locator<AuthBloc>().state.currentUser!.username;
    final fileName = '$userUsername${Constants.imageFormat}';

    final ref = FirebaseStorage.instance
        .ref()
        .child(users)
        .child(userUsername)
        .child(fileName);

    TaskSnapshot task;
    task = await ref.putFile(file);
    final fileUrl = await task.ref.getDownloadURL();
    return fileUrl;
  }
}
