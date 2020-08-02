import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
import 'package:moleculis/models/contact/contact.dart';
import 'package:moleculis/models/requests/login_request.dart';
import 'package:moleculis/models/requests/register_request.dart';
import 'package:moleculis/models/requests/update_user_request.dart';
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
        _userService = userService,
        super(AuthenticationState());

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

  Stream<AuthenticationState> _login(String username, String password) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _authenticationService.login(
        LoginRequest(
          username: username,
          password: password,
        ),
      );
      yield AuthenticationSuccess(message: 'Logged in successfully');
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
      final List<User> otherUsers = await _userService.getOtherUsers();
      yield state.copyWith(
          isLoading: false, currentUser: user, otherUsers: otherUsers);
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

  Stream<AuthenticationState> _updateUser(UpdateUserRequest request) async* {
    try {
      yield state.copyWith(isLoading: true);
      final String message = await _userService.updateUser(request);
      yield AuthenticationSuccess(message: message);
      yield state.copyWith(
        isLoading: false,
        currentUser: state.currentUser.copyWithRequest(request),
      );
    } on AppException catch (e) {
      yield AuthenticationFailure(error: e.toString());
    }
  }

  Stream<AuthenticationState> _removeContact(int id) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _userService.deleteContact(id);
      final List<Contact> contacts = state.currentUser.contacts;
      final List<Contact> contactRequests = state.currentUser.contactRequests;
      bool found = false;
      for (Contact contact in contacts) {
        if (contact.id == id) {
          contacts.remove(contact);
          found = true;
          break;
        }
      }
      if (!found) {
        for (Contact contact in contactRequests) {
          if (contact.id == id) {
            contactRequests.remove(contact);
            break;
          }
        }
      }
      yield state.copyWith(
        isLoading: false,
        currentUser: state.currentUser.copyWith(
          contacts: contacts,
          contactRequests: contactRequests,
        ),
      );
    } on AppException catch (e) {
      yield AuthenticationFailure(error: e.toString());
    }
  }

  Stream<AuthenticationState> _acceptContact(int id) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _userService.acceptContact(id);
      yield* _loadInitialData();
    } on AppException catch (e) {
      yield AuthenticationFailure(error: e.toString());
    }
  }

  Stream<AuthenticationState> _sendContactRequest(String username) async* {
    try {
      yield state.copyWith(isLoading: true);
      await _userService.sendContactRequest(username);
      yield* _loadInitialData();
    } on AppException catch (e) {
      yield AuthenticationFailure(error: e.toString());
    }
  }
}
