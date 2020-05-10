import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';

import 'http_helper.dart';

class UserService {
  final HttpHelper _httpHelper;
  final String _endpointBase = '/users';

  UserService(this._httpHelper);

  String get _currentUserEndpoint => _endpointBase + '/current';

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
}
