import 'package:meta/meta.dart';
import 'package:moleculis/models/user/user.dart';

@immutable
class AuthState {
  final bool isLoading;
  final User? currentUser;
  final List<User>? otherUsers;

  AuthState({
    this.isLoading = false,
    this.currentUser,
    this.otherUsers,
  });

  AuthState copyWith({
    bool? isLoading,
    User? currentUser,
    List<User>? otherUsers,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      otherUsers: otherUsers ?? this.otherUsers,
    );
  }
}

class UnauthorizedState extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error}) : super();

  @override
  String toString() => 'AuthFailure { error: $error }';
}

class AuthSuccess extends AuthState {
  final String? message;

  AuthSuccess({required this.message}) : super();

  @override
  String toString() => 'AuthenticationSuccess { message: $message }';
}

class RegisterSuccess extends AuthState {
  final String? message;

  RegisterSuccess({required this.message}) : super();

  @override
  String toString() => 'RegisterSuccess { message: $message }';
}

class LogOutSuccess extends AuthState {
  final String? message;

  LogOutSuccess({required this.message}) : super();

  @override
  String toString() => 'LogOutSuccess { message: $message }';
}
