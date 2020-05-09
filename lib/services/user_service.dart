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
}
