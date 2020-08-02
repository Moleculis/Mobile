import 'package:meta/meta.dart';
import 'package:moleculis/models/user/user.dart';

@immutable
class AuthenticationState {
  final bool isLoading;
  final User currentUser;
  final List<User> otherUsers;

  AuthenticationState({
    this.isLoading = false,
    this.currentUser,
    this.otherUsers,
  });

  AuthenticationState copyWith({
    bool isLoading,
    User currentUser,
    List<User> otherUsers,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      otherUsers: otherUsers ?? this.otherUsers,
    );
  }
}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  AuthenticationFailure({@required this.error}) : super();

  @override
  String toString() => 'AuthenticationFailure { error: $error }';
}

class AuthenticationSuccess extends AuthenticationState {
  final String message;

  AuthenticationSuccess({@required this.message}) : super();

  @override
  String toString() => 'AuthenticationSuccess { message: $message }';
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
