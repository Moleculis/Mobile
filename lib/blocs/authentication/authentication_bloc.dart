import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
import 'package:moleculis/models/requests/login_request.dart';
import 'package:moleculis/models/requests/register_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/services/authentication_service.dart';
import 'package:moleculis/services/user_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  final UserService _userService;

  AuthenticationBloc(
      {AuthenticationService authenticationService, UserService userService})
      : _authenticationService = authenticationService,
        _userService = userService;

  @override
  AuthenticationState get initialState => AuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is LoginEvent) {
      yield* _login(event.username, event.password);
    } else if (event is RegisterEvent) {
      yield* _register(event.registerRequest);
    } else if (event is LoadInitialData) {
      yield* _loadInitialData();
    } else if (event is LogOutEvent) {
      yield* _logout();
    }
  }

  Stream<AuthenticationState> _login(String username, String password) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _authenticationService.login(
        LoginRequest(
          username: username,
          password: password,
        ),
      );
      yield AuthenticationLoginSuccess(message: 'Logged in successfully');
    } on AppException catch (e) {
      yield AuthenticationFailure(error: e.toString());
    } finally {
      yield state.copyWith(
        isLoading: false,
      );
    }
  }

  Stream<AuthenticationState> _register(
      RegisterRequest registerRequest) async* {
    try {
      yield state.copyWith(isLoading: true);
      final String message =
      await _authenticationService.register(registerRequest);
      yield AuthenticationRegisterSuccess(message: message);
    } on AppException catch (e) {
      yield AuthenticationFailure(error: e.toString());
    } finally {
      yield state.copyWith(
        isLoading: false,
      );
    }
  }

  Stream<AuthenticationState> _loadInitialData() async* {
    try {
      yield state.copyWith(isLoading: true);
      final User user = await _userService.getCurrentUser();
      yield state.copyWith(
        isLoading: false,
        currentUser: user,
      );
    } on AppException catch (e) {
      yield AuthenticationFailure(error: e.toString());
    }
  }

  Stream<AuthenticationState> _logout() async* {
    try {
      yield state.copyWith(isLoading: true);
      final String message = await _authenticationService.logOut();
      yield AuthenticationLogOutSuccess(message: message);
    } on AppException catch (e) {
      yield AuthenticationFailure(error: e.toString());
    } finally {
      yield state.copyWith(
        isLoading: false,
      );
    }
  }
}
