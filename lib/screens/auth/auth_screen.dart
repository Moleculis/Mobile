import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/auth/auth_state.dart';
import 'package:moleculis/screens/auth/create_edit_user_screen.dart';
import 'package:moleculis/screens/auth/login_screen.dart';
import 'package:moleculis/screens/home/home_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/languages_popup.dart';
import 'package:moleculis/widgets/loading_widget.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AuthBloc authBloc;
  late final TabController authTabsController;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authTabsController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is AuthSuccess) {
          Navigation.toScreenAndCleanBackStack(
              context: context, screen: HomeScreen());
        } else if (state is RegisterSuccess) {
          authTabsController.animateTo(0);
          WidgetUtils.showSuccessSnackbar(context, message: state.message!);
        } else if (state is AuthFailure) {
          WidgetUtils.showErrorSnackbar(context, error: state.error);
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TabBar(
                        controller: authTabsController,
                        tabs: [
                          Tab(
                            child: Text(
                              'login'.tr(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'register'.tr(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            TabBarView(
                              controller: authTabsController,
                              children: [
                                LoginScreen(),
                                CreateEditUserScreen(),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: LanguagesPopup(context: context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state.isLoading) LoadingWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
