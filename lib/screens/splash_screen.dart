import 'package:flutter/material.dart';
import 'package:moleculis/screens/home/home_screen.dart';
import 'package:moleculis/screens/login/login_screen.dart';
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
            context: context, screen: HomeScreen());
      } else {
        Navigation.toScreenAndCleanBackStack(
            context: context, screen: LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash screen'),
      ),
    );
  }
}
