import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
import 'package:moleculis/screens/home/home_screen.dart';
import 'package:moleculis/utils/locale_utils.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/loading_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationBloc authenticationBloc;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationSuccess) {
          Navigation.toScreenAndCleanBackStack(
              context: context, screen: HomeScreen());
        } else if (state is AuthenticationFailure) {
          WidgetUtils.showErrorSnackbar(scaffoldKey, state.error);
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
              return Stack(
                children: <Widget>[
                  Center(
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(
                                  controller: usernameController,
                                  focusNode: usernameFocus,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (String value) {
                                    usernameFocus.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocus);
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Username'),
                                  validator: (String value) {
                                    value = value.trim();
                                    if (value.isEmpty) {
                                      return "Username can't be empty";
                                    }
                                    if (value.length < 5) {
                                      return "Username is too short";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(
                                  controller: passwordController,
                                  focusNode: passwordFocus,
                                  onFieldSubmitted: (String value) {
                                    login();
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Password'),
                                  validator: (String value) {
                                    value = value.trim();
                                    if (value.isEmpty) {
                                      return "Password can't be empty";
                                    }
                                    if (value.length < 5) {
                                      return "Password is too short";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              RaisedButton(
                                onPressed: login,
                                child: Text('login'.tr()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state.isLoading) LoadingWidget(),
                ],
              );
            }
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState.validate()) {
      usernameFocus.unfocus();
      passwordFocus.unfocus();
      authenticationBloc.add(
        LoginEvent(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    } else {
      context.locale = LocaleUtils.locales[0];
    }
  }
}
