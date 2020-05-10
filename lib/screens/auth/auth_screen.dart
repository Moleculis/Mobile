import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
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
  AuthenticationBloc authenticationBloc;
  TabController authTabsController;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    authTabsController = TabController(length: 2, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationLoginSuccess) {
          Navigation.toScreenAndCleanBackStack(
              context: context, screen: HomeScreen());
        } else if (state is AuthenticationRegisterSuccess) {
          authTabsController.animateTo(0);
          WidgetUtils.showSuccessSnackbar(scaffoldKey, state.message);
        } else if (state is AuthenticationFailure) {
          WidgetUtils.showErrorSnackbar(scaffoldKey, state.error);
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            bloc: authenticationBloc,
            builder: (BuildContext context, AuthenticationState state) {
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
                                child: LanguagesPopup(context: context,),
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
            }),
      ),
    );
  }
}
