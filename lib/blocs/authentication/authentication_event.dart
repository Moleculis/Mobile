import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

class LoginEvent extends AuthenticationEvent {
  final String username;
  final String password;

  LoginEvent({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class LoadInitialData extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}
