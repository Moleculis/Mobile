import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/models/user/user_model.dart';
import 'package:moleculis/services/apis/user_service.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/values/collections_refs.dart';

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
    return User.fromMap(response);
  }

  @override
  Stream<UserModel?> currentUserModelStream([String? username]) {
    final currentUserUsername = username ??
        locator<AuthBloc>().state.currentUser!.username;
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
}
