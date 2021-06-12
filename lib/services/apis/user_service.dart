import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/models/user/user_model.dart';

abstract class UserService {
  Future<User> getCurrentUser();

  Stream<UserModel?> currentUserModelStream([String? username]);

  Future<void> updateUserDeviceToken(UserModel user);

  Future<void> deleteCurrentUserDeviceToken();

  Future<void> createUserModel();

  Future<String?> updateUser(UpdateUserRequest request);

  Future<String?> sendContactRequest(String? username);

  Future<String?> deleteContact(int id);

  Future<String?> acceptContact(int id);

  Future<List<User>> getUsers();

  Future<List<User>> getOtherUsers();
}
