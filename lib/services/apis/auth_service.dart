import 'package:moleculis/models/requests/login_request.dart';
import 'package:moleculis/models/requests/register_request.dart';

abstract class AuthService {
  Future<void> login(LoginRequest request);

  Future<String?> register(RegisterRequest request);

  Future<String?> logOut();
}
