import 'package:meta/meta.dart';
import 'package:moleculis/models/user/user.dart';

@immutable
class AuthenticationState {
  final bool isLoading;
  final User currentUser;

  AuthenticationState({
    this.isLoading = false,
    this.currentUser,
  });

  AuthenticationState copyWith({
    bool isLoading,
    User currentUser,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  AuthenticationFailure({@required this.error}) : super();

  @override
  String toString() => 'AuthenticationFailure { error: $error }';
}

class AuthenticationLoginSuccess extends AuthenticationState {
  final String message;

  AuthenticationLoginSuccess({@required this.message}) : super();

  @override
  String toString() => 'AuthenticationLoginSuccess { message: $message }';
}

class AuthenticationRegisterSuccess extends AuthenticationState {
  final String message;

  AuthenticationRegisterSuccess({@required this.message}) : super();

  @override
  String toString() => 'AuthenticationRegisterSuccess { message: $message }';
}

class AuthenticationLogOutSuccess extends AuthenticationState {
  final String message;

  AuthenticationLogOutSuccess({@required this.message}) : super();

  @override
  String toString() => 'AuthenticationLogOutSuccess { message: $message }';
}
