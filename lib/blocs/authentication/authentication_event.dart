import 'package:equatable/equatable.dart';
import 'package:moleculis/models/requests/register_request.dart';

abstract class AuthenticationEvent extends Equatable {}

class LoginEvent extends AuthenticationEvent {
  final String username;
  final String password;

  LoginEvent({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthenticationEvent {
  final RegisterRequest registerRequest;

  RegisterEvent(this.registerRequest);

  @override
  List<Object> get props => [registerRequest];
}

class LoadInitialData extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}

class LogOutEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
