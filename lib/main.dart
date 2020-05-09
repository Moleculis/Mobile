import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moleculis/screens/error_screen.dart';
import 'package:moleculis/screens/login/login_screen.dart';
import 'package:moleculis/utils/locale_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  runApp(
    EasyLocalization(
      supportedLocales: LocaleUtils.locales,
      path: LocaleUtils.localePath,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var easyLocalization;

  @override
  void didChangeDependencies() {
    easyLocalization = EasyLocalization.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moleculis',
      theme: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(primaryColor: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        accentColor: Color.fromRGBO(238, 165, 65, 1),
        textTheme: GoogleFonts.firaSansTextTheme(
          Theme
              .of(context)
              .textTheme,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 25,
              letterSpacing: -2,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return ErrorScreen(
            details: details,
            showStacktrace: true,
          );
        };
        return widget;
      },
      home: LoginScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        easyLocalization.delegate,
      ],
      supportedLocales: easyLocalization.supportedLocales,
      locale: easyLocalization.locale,
    );
  }
}
