import 'package:equatable/equatable.dart';
import 'package:moleculis/models/requests/register_request.dart';
import 'package:moleculis/models/requests/update_user_request.dart';

abstract class AuthEvent extends Equatable {}

class SilentLoginEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class ReloadUserEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final RegisterRequest registerRequest;

  RegisterEvent(this.registerRequest);

  @override
  List<Object> get props => [registerRequest];
}

class LogOutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends AuthEvent {
  final UpdateUserRequest request;

  UpdateUserEvent(this.request);

  @override
  List<Object> get props => [request];
}

class RemoveContactEvent extends AuthEvent {
  final int id;

  RemoveContactEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AcceptContactEvent extends AuthEvent {
  final int id;

  AcceptContactEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SendContactRequestEvent extends AuthEvent {
  final String username;

  SendContactRequestEvent(this.username);

  @override
  List<Object> get props => [];
}
