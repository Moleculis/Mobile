import 'package:equatable/equatable.dart';
import 'package:moleculis/models/requests/register_request.dart';
import 'package:moleculis/models/requests/update_user_request.dart';

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

class UpdateUserEvent extends AuthenticationEvent {
  final UpdateUserRequest request;

  UpdateUserEvent(this.request);

  @override
  List<Object> get props => [request];
}

class RemoveContactEvent extends AuthenticationEvent {
  final int id;

  RemoveContactEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AcceptContactEvent extends AuthenticationEvent {
  final int id;

  AcceptContactEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SendContactRequestEvent extends AuthenticationEvent {
  final String username;

  SendContactRequestEvent(this.username);

  @override
  List<Object> get props => null;
}