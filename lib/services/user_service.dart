import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';

import 'http_helper.dart';

class UserService {
  final HttpHelper _httpHelper;
  final String _endpointBase = '/users';

  UserService(this._httpHelper);

  String get _currentUserEndpoint => _endpointBase + '/current';

  String get _usersEndpoint => _endpointBase + '/';

  String _deleteContactEndpoint(int id) =>
      _endpointBase + '/delete_contact/$id';

  String _acceptContactEndpoint(int id) =>
      _endpointBase + '/accept_contact_request/$id';

  Future<User> getCurrentUser() async {
    final Map<String, dynamic> response =
    await _httpHelper.get(_currentUserEndpoint);
    return User.fromMap(response);
  }

  Future<String> updateUser(UpdateUserRequest request) async {
    final Map<String, dynamic> response = await _httpHelper.put(
      _currentUserEndpoint,
      body: request.toMap(),
    );
    return response['message'];
  }

  Future<String> deleteContact(int id) async {
    final Map<String, dynamic> response = await _httpHelper.delete(
      _deleteContactEndpoint(id),
    );
    return response['message'];
  }

  Future<String> acceptContact(int id) async {
    final Map<String, dynamic> response = await _httpHelper.post(
      _acceptContactEndpoint(id),
    );
    return response['message'];
  }

  Future<List<User>> getUsers() async {
    final List<dynamic> response =
    await _httpHelper.get(_usersEndpoint);
    final List<User> users = response.map((e) => User.fromMap(e)).toList();
    return users;
  }
}
