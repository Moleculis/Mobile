import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/services/apis/user_service.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/utils/locator.dart';

class UserServiceImpl implements UserService {
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
