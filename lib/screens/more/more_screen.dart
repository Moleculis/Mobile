import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
import 'package:moleculis/screens/auth/auth_screen.dart';
import 'package:moleculis/screens/contacts/contacts_screen.dart';
import 'package:moleculis/screens/more/widgets/more_tile.dart';
import 'package:moleculis/screens/settings/settings_screen.dart';
import 'package:moleculis/screens/user_details/user_details_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/big_tile.dart';
import 'package:package_info/package_info.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  PackageInfo packageInfo;
  AuthenticationBloc authenticationBloc;
  AuthenticationState authState;

  @override
  void initState() {
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        packageInfo = value;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationLogOutSuccess) {
          Navigation.toScreenAndCleanBackStack(
              context: context, screen: AuthScreen());
        }
      },
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 10,
                top: 20,
              ),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                bloc: authenticationBloc,
                builder: (BuildContext context, AuthenticationState state) {
                  if (state.currentUser == null) {
                    return Container(
                      height: 100,
                    );
                  }
                  return BigTile(
                    title: state.currentUser.fullname,
                    subtitle: state.currentUser.username,
                    trailing: IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {
                        WidgetUtils.showSimpleDialog(
                          context: context,
                          title: 'log_out_confirm'.tr(),
                          onYes: () {
                            authenticationBloc.add(LogOutEvent());
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 20),
                children: <Widget>[
                  SettingsTile(
                    title: 'personal_info'.tr(),
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.grey[600],
                    ),
                    onTap: () {
                      Navigation.toScreen(
                        context: context,
                        screen: UserDetails(),
                      );
                    },
                  ),
                  SettingsTile(
                    title: 'contact'.plural(2),
                    icon: Icon(
                      Icons.contacts,
                      color: Colors.grey[600],
                    ),
                    onTap: () async {
                      Navigation.toScreen(
                          context: context, screen: ContactsScreen());
                    },
                  ),
                  SettingsTile(
                    title: 'settings'.tr(),
                    icon: Icon(
                      Icons.settings,
                      color: Colors.grey[600],
                    ),
                    onTap: () async {
                      await Navigation.toScreen(
                          context: context, screen: SettingsScreen());
                      setState(() {});
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                        '${'version'.tr()}: ${packageInfo
                            ?.version}+${packageInfo?.buildNumber}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}