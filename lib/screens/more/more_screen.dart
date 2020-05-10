import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/screens/more/widgets/settings_tile.dart';
import 'package:package_info/package_info.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  PackageInfo packageInfo;

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(bottom: 50, left: 20, right: 20, top: 20),
        children: <Widget>[
          //ToDo User Tile
          SettingsTile(
            title: 'personal_info'.tr(),
            icon: Icon(
              Icons.person_outline,
              color: Colors.grey[600],
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
                '${'version'.tr()}: ${packageInfo?.version}+${packageInfo?.buildNumber}'),
          ),
        ],
      ),
    );
  }
}
