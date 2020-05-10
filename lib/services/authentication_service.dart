import 'package:moleculis/models/requests/login_request.dart';
import 'package:moleculis/models/requests/register_request.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';
import 'package:moleculis/utils/jwt.dart';

class AuthenticationService {
  final HttpHelper _httpHelper;
  final SharedPrefManager _sharedPrefManager = SharedPrefManager();
  final String _endpointBase = '/users';

  AuthenticationService(this._httpHelper);

  String get _loginEndpoint => _endpointBase + '/login';

  String get _registerEndpoint => _endpointBase + '/register';

  Future<void> login(LoginRequest request) async {
    final Map<String, dynamic> response = await _httpHelper.post(
      _loginEndpoint,
      body: request.toMap(),
      authorized: false,
    );

    final Map<String, dynamic> jwt = JWT.parseJwt(response['token']);
    final int exp = jwt['exp'] as int;

    await _sharedPrefManager.saveAccessToken(response['token'], exp * 1000);
  }

  Future<String> register(RegisterRequest request) async {
    final Map<String, dynamic> response = await _httpHelper.post(
      _registerEndpoint,
      body: request.toMap(),
      authorized: false,
    );
    return response['message'];
  }
}
