import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/auth/auth_event.dart';
import 'package:moleculis/blocs/auth/auth_state.dart';
import 'package:moleculis/models/contact.dart';
import 'package:moleculis/models/requests/login_request.dart';
import 'package:moleculis/models/requests/register_request.dart';
import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/services/apis/auth_service.dart';
import 'package:moleculis/services/apis/user_service.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';
import 'package:moleculis/utils/locator.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = locator<AuthService>();
  final UserService _userService = locator<UserService>();

  AuthBloc() : super(AuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SilentLoginEvent) {
      yield* _silentLogin();
    } else if (event is ReloadUserEvent) {
      yield* _reloadUser();
    } else if (event is LoginEvent) {
      yield* _login(event.username, event.password);
    } else if (event is RegisterEvent) {
      yield* _register(event.registerRequest);
    } else if (event is LogOutEvent) {
      yield* _logout();
    } else if (event is UpdateUserEvent) {
      yield* _updateUser(event.request);
    } else if (event is RemoveContactEvent) {
      yield* _removeContact(event.id);
    } else if (event is AcceptContactEvent) {
      yield* _acceptContact(event.id);
    } else if (event is SendContactRequestEvent) {
      yield* _sendContactRequest(event.username);
    }
  }

  Stream<AuthState> _silentLogin() async* {
    final bool authenticated = locator<SharedPrefManager>().authenticated;

    if (authenticated) {
      yield* _reloadUser();
    } else {
      yield UnauthorizedState();
    }
  }

  Stream<AuthState> _reloadUser() async* {
    try {
      yield state.copyWith(isLoading: true);
      final User user = await _userService.getCurrentUser();
      final List<User> otherUsers = await _userService.getOtherUsers();
      yield state.copyWith(
        isLoading: false,
        currentUser: user,
        otherUsers: otherUsers,
      );
    } on AppException catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  Stream<AuthState> _login(String username, String password) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _authService.login(
        LoginRequest(
          username: username,
          password: password,
        ),
      );
      yield AuthSuccess(message: 'Logged in successfully');
    } on AppException catch (e) {
      yield AuthFailure(error: e.toString());
    } finally {
      yield state.copyWith(
        isLoading: false,
      );
    }
  }

  Stream<AuthState> _register(RegisterRequest registerRequest) async* {
    try {
      yield state.copyWith(isLoading: true);
      final String? message = await _authService.register(registerRequest);
      yield RegisterSuccess(message: message);
    } on AppException catch (e) {
      yield AuthFailure(error: e.toString());
    } finally {
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<AuthState> _logout() async* {
    try {
      yield state.copyWith(isLoading: true);
      final String? message = await _authService.logOut();
      yield LogOutSuccess(message: message);
    } on AppException catch (e) {
      yield AuthFailure(error: e.toString());
    } finally {
      yield state.copyWith(
        isLoading: false,
      );
    }
  }

  Stream<AuthState> _updateUser(UpdateUserRequest request) async* {
    try {
      yield state.copyWith(isLoading: true);
      final String? message = await _userService.updateUser(request);
      yield AuthSuccess(message: message);
      yield state.copyWith(
        isLoading: false,
        currentUser: state.currentUser!.copyWithRequest(request),
      );
    } on AppException catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  Stream<AuthState> _removeContact(int id) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _userService.deleteContact(id);
      final List<Contact> contacts = state.currentUser!.contacts!;
      final List<Contact>? contactRequests = state.currentUser!.contactRequests;
      bool found = false;
      for (final contact in contacts) {
        if (contact.id == id) {
          contacts.remove(contact);
          found = true;
          break;
        }
      }
      if (!found) {
        for (final contact in contactRequests!) {
          if (contact.id == id) {
            contactRequests.remove(contact);
            break;
          }
        }
      }
      yield state.copyWith(
        isLoading: false,
        currentUser: state.currentUser!.copyWith(
          contacts: contacts,
          contactRequests: contactRequests,
        ),
      );
    } on AppException catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  Stream<AuthState> _acceptContact(int id) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _userService.acceptContact(id);
      yield* _reloadUser();
    } on AppException catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }

  Stream<AuthState> _sendContactRequest(String? username) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _userService.sendContactRequest(username);
      yield* _reloadUser();
    } on AppException catch (e) {
      yield AuthFailure(error: e.toString());
    }
  }
}
