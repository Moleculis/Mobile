import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/auth/auth_event.dart';
import 'package:moleculis/blocs/auth/auth_state.dart';
import 'package:moleculis/common/img.dart';
import 'package:moleculis/screens/auth/auth_screen.dart';
import 'package:moleculis/screens/home/home_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(SilentLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) {
        if (state is UnauthorizedState) {
          Navigation.toScreenAndCleanBackStack(
            context: context,
            screen: AuthScreen(),
          );
        } else if (state.currentUser != null) {
          Navigation.toScreenAndCleanBackStack(
            context: context,
            screen: HomeScreen(),
          );
        } else if (state is AuthFailure) {
          WidgetUtils.showErrorSnackbar(context, error: state.error);
        }
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Image.asset(Img.logo),
          ),
        ),
      ),
    );
  }
}
