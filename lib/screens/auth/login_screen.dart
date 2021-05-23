import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/auth/auth_event.dart';
import 'package:moleculis/widgets/gradient_button.dart';
import 'package:moleculis/widgets/input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey();

  late final AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 100,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Input(
                  controller: usernameController,
                  focusNode: usernameFocus,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  nextFocusNode: passwordFocus,
                  onFieldSubmitted: (String value) {},
                  validator: (String? value) {
                    value = value!.trim();
                    if (value.isEmpty) {
                      return 'username_empty'.tr();
                    }
                    if (value.length < 5) {
                      return 'username_short'.tr();
                    }
                    return null;
                  },
                  title: 'username'.tr(),
                ),
              ),
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 60,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Input(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    onFieldSubmitted: (String value) {
                      login();
                    },
                    maxLines: 1,
                    validator: (String? value) {
                      value = value!.trim();
                      if (value.isEmpty) {
                        return 'password_empty'.tr();
                      }
                      if (value.length < 5) {
                        return 'password_short'.tr();
                      }
                      return null;
                    },
                    title: 'password'.tr(),
                    obscureText: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GradientButton(
                  onPressed: login,
                  text: 'login'.tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      usernameFocus.unfocus();
      passwordFocus.unfocus();
      authBloc.add(
        LoginEvent(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }
}
