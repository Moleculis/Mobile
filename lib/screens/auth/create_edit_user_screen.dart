import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
import 'package:moleculis/models/enums/gender.dart';
import 'package:moleculis/models/requests/register_request.dart';
import 'package:moleculis/models/requests/update_user_request.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/utils/validation.dart';
import 'package:moleculis/widgets/gradient_button.dart';
import 'package:moleculis/widgets/input.dart';
import 'package:moleculis/widgets/loading_widget.dart';
import 'package:moleculis/widgets/toolbar.dart';

class CreateEditUserScreen extends StatefulWidget {
  final bool edit;

  const CreateEditUserScreen({Key key, this.edit = false}) : super(key: key);

  @override
  _CreateEditUserScreenState createState() => _CreateEditUserScreenState();
}

class _CreateEditUserScreenState extends State<CreateEditUserScreen>
    with AutomaticKeepAliveClientMixin {
  AuthenticationBloc authenticationBloc;

  final TextEditingController usernameController = TextEditingController();
  final FocusNode usernameFocus = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  final TextEditingController password2Controller = TextEditingController();
  final FocusNode password2Focus = FocusNode();

  final TextEditingController displayNameController = TextEditingController();
  final FocusNode displayNameFocus = FocusNode();

  final TextEditingController fullNameController = TextEditingController();
  final FocusNode fullNameFocus = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  Gender currentGender = Gender.male;

  File pickedImage;

  @override
  bool get wantKeepAlive => true;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void didChangeDependencies() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    if (widget.edit) {
      final User currentUser = authenticationBloc.state.currentUser;
      usernameController.text = currentUser.username;
      emailController.text = currentUser.email;
      displayNameController.text = currentUser.displayname;
      fullNameController.text = currentUser.fullname;
      currentGender = currentUser.gender.gender;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (widget.edit) {
          if (state is AuthenticationSuccess) {
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState authState) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: widget.edit ? 0 : 40,
                        ),
                        child: Column(
                          children: <Widget>[
                            if (widget.edit)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20),
                                child: Toolbar(
                                  title: 'edit_personal_info'.tr(),
                                  backButton: true,
                                  onImagePicked: (File image) {
                                    pickedImage = image;
                                  },
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Input(
                                controller: usernameController,
                                focusNode: usernameFocus,
                                nextFocusNode: passwordFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {},
                                validator: (String value) {
                                  value = value.trim();
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
                            if (!widget.edit)
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
                                    nextFocusNode: password2Focus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String value) {},
                                    maxLines: 1,
                                    validator: (String value) {
                                      value = value.trim();
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
                            if (!widget.edit)
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Input(
                                    controller: password2Controller,
                                    focusNode: password2Focus,
                                    nextFocusNode: emailFocus,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String value) {},
                                    maxLines: 1,
                                    validator: (String value) {
                                      value = value.trim();
                                      if (value.isEmpty) {
                                        return 'password_empty'.tr();
                                      }
                                      if (value.length < 5) {
                                        return 'password_short'.tr();
                                      }
                                      if (passwordController.text != value) {
                                        return 'passwords_no_match'.tr();
                                      }
                                      return null;
                                    },
                                    title: 'password_again'.tr(),
                                    obscureText: true,
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Input(
                                controller: emailController,
                                focusNode: emailFocus,
                                nextFocusNode: displayNameFocus,
                                textInputAction: TextInputAction.next,
                                inputType: TextInputType.emailAddress,
                                onFieldSubmitted: (String value) {},
                                validator: (String value) {
                                  value = value.trim();
                                  if (value.isEmpty) {
                                    return 'email_empty'.tr();
                                  }
                                  if (Validation.emailRegExp.hasMatch(value)) {
                                    return 'email_wrong'.tr();
                                  }
                                  return null;
                                },
                                title: 'email'.tr(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Input(
                                controller: displayNameController,
                                focusNode: displayNameFocus,
                                nextFocusNode: fullNameFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {},
                                validator: (String value) {
                                  value = value.trim();
                                  if (value.length > 20) {
                                    return 'display_name_long'.tr();
                                  }
                                  if (value.isNotEmpty && value.length < 5) {
                                    return 'display_name_short'.tr();
                                  }
                                  return null;
                                },
                                title: 'display_name'.tr(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Input(
                                controller: fullNameController,
                                focusNode: fullNameFocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String value) {},
                                validator: (String value) {
                                  if (value.length > 50) {
                                    return 'full_name_long'.tr();
                                  }
                                  if (value.isNotEmpty && value.length < 5) {
                                    return 'full_name_short'.tr();
                                  }
                                  return null;
                                },
                                title: 'full_name'.tr(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('gender'.tr(),
                                      style:
                                      Theme
                                          .of(context)
                                          .textTheme
                                          .caption),
                                  ...Gender.values.map((Gender gender) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentGender = gender;
                                        });
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Radio<Gender>(
                                              groupValue: currentGender,
                                              value: gender,
                                              onChanged: (Gender value) {
                                                setState(() {
                                                  currentGender = value;
                                                });
                                              },
                                            ),
                                          ),
                                          Text(gender.assetName.tr()),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GradientButton(
                                onPressed: register,
                                text:
                                widget.edit ? 'save'.tr() : 'register'.tr(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (authState.isLoading && widget.edit) LoadingWidget(),
                ],
              ),
            );
          }),
    );
  }

  void register() {
    if (formKey.currentState.validate()) {
      usernameFocus.unfocus();
      passwordFocus.unfocus();
      password2Focus.unfocus();
      displayNameFocus.unfocus();
      fullNameFocus.unfocus();
      emailFocus.unfocus();
      if (widget.edit) {
        final UpdateUserRequest updateUserRequest = UpdateUserRequest(
          username: usernameController.text,
          displayName: displayNameController.text,
          fullName: fullNameController.text,
          email: emailController.text,
          gender: currentGender,
        );
        authenticationBloc.add(UpdateUserEvent(updateUserRequest));
      } else {
        final RegisterRequest registerRequest = RegisterRequest(
          username: usernameController.text,
          password: passwordController.text,
          displayName: displayNameController.text,
          fullName: fullNameController.text,
          email: emailController.text,
          gender: currentGender,
        );
        authenticationBloc.add(RegisterEvent(registerRequest));
      }
    }
  }
}
