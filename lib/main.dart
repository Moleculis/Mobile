import 'package:flutter/material.dart';
import 'package:moleculis/screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moleculis',
      home: LoginScreen(),
    );
  }
}
