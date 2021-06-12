import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';

abstract class UserService {
  Future<User> getCurrentUser();

  Future<String?> updateUser(UpdateUserRequest request);

  Future<String?> sendContactRequest(String? username);

  Future<String?> deleteContact(int id);

  Future<String?> acceptContact(int id);

  Future<List<User>> getUsers();

  Future<List<User>> getOtherUsers();
}
