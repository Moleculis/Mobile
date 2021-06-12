import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/common/colors.dart';
import 'package:moleculis/screens/error_screen.dart';
import 'package:moleculis/screens/splash_screen.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';
import 'package:moleculis/utils/locale_utils.dart';
import 'package:moleculis/utils/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  setupServiceLocator();

  final prefManager = locator<SharedPrefManager>();
  await prefManager.init();

  runApp(
    EasyLocalization(
      supportedLocales: LocaleUtils.locales,
      startLocale: prefManager.currentLocale,
      fallbackLocale: LocaleUtils.defaultLocale,
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
  late var easyLocalization;

  @override
  void didChangeDependencies() {
    easyLocalization = EasyLocalization.of(context);
    locator<HttpHelper>().updateLocale(easyLocalization.locale.languageCode);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => locator<AuthBloc>()),
      ],
      child: MaterialApp(
        title: 'Moleculis',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          cupertinoOverrideTheme:
              CupertinoThemeData(primaryColor: Colors.black),
          scaffoldBackgroundColor: backgroundColor,
          accentColor: accentColor,
          textTheme: GoogleFonts.firaSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: backgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            actionsIconTheme: IconThemeData(color: Colors.black),
            textTheme: Theme.of(context).textTheme.copyWith(
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
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails details) {
            return ErrorScreen(
              details: details,
              showStacktrace: true,
            );
          };
          return widget!;
        },
        home: SplashScreen(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          easyLocalization.delegate,
        ],
        supportedLocales: easyLocalization.supportedLocales,
        locale: easyLocalization.locale,
      ),
    );
  }
}
