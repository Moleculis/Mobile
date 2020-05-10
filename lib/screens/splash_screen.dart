import 'package:flutter/material.dart';
import 'package:moleculis/common/img.dart';
import 'package:moleculis/screens/auth/auth_screen.dart';
import 'package:moleculis/screens/home/home_screen.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';
import 'package:moleculis/utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SharedPrefManager().isAuthenticated().then((bool authenticated) {
      if (authenticated) {
        Navigation.toScreenAndCleanBackStack(
          context: context,
          screen: HomeScreen(),
        );
      } else {
        Navigation.toScreenAndCleanBackStack(
          context: context,
          screen: AuthScreen(),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width - 100,
          child: Image.asset(Img.logo),
        ),
      ),
    );
  }
}
