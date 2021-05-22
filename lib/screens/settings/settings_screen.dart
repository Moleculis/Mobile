import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/common/colors.dart';
import 'package:moleculis/screens/settings/choose_language_screen.dart';
import 'package:moleculis/utils/locale_utils.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/languages_popup.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool fingerprintSwitchValue = false;
  bool notificationsSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.appBar(
        context,
        title: 'settings'.tr().toLowerCase(),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? settingsBackgroundColor
            : Colors.black,
      ),
      body: _getBody(),
      backgroundColor: settingsBackgroundColor,
    );
  }

  Widget _getBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'general'.tr(),
                style:
                    TextStyle(color: accentColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: LanguagesPopup(
                  context: context,
                  backgroundColor: settingsBackgroundColor,
                  showIcon: false,
                  child: SettingsTile(
                    title: 'language'.tr(),
                    subtitle: LocaleUtils.currentLocaleItem(context).name,
                    leading: Icon(Icons.language),
                    onPressed: (_) async {
                      if (Platform.isIOS) {
                        final int? index = await Navigation.toScreen(
                          context: context,
                          screen: ChooseLanguageScreen(),
                        );
                        if (index != null) {
                          this
                              .context
                              .setLocale(LocaleUtils.localeItems[index].locale);
                        }
                      }
                    },
                  ),
                ),
              ),
              SettingsTile.switchTile(
                title: 'notifications'.tr(),
                leading: Icon(Icons.notifications_none),
                switchValue: notificationsSwitchValue,
                onToggle: (bool value) {
                  setState(() {
                    notificationsSwitchValue = !notificationsSwitchValue;
                  });
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'security'.tr(),
                style:
                    TextStyle(color: accentColor, fontWeight: FontWeight.bold),
              ),
              SettingsTile.switchTile(
                title: 'use_fingerprint'.tr(),
                leading: Icon(Icons.fingerprint),
                switchValue: fingerprintSwitchValue,
                onToggle: (bool value) {
                  setState(() {
                    fingerprintSwitchValue = !fingerprintSwitchValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
