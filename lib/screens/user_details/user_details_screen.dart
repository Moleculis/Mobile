import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_state.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/screens/auth/create_edit_user_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/big_tile.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  AuthenticationBloc authenticationBloc;

  @override
  void didChangeDependencies() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationState authState = authenticationBloc.state;
    final User currentUser = authState.currentUser;
    return Scaffold(
      appBar: WidgetUtils.appBar(context,
          title: 'personal_info'.tr().toLowerCase(),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                await Navigation.toScreen(
                  context: context,
                  screen: Scaffold(
                    appBar: WidgetUtils.appBar(
                      context,
                      title: 'edit_personal_info'.tr().toLowerCase(),
                    ),
                    body: CreateEditUserScreen(
                      edit: true,
                    ),
                  ),
                );
                setState(() {});
              },
            ),
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BigTile(
                  title: currentUser.fullname,
                  subtitle: currentUser.username,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Divider(),
                ),
                infoItem(title: 'email'.tr(), content: currentUser.email),
                infoItem(
                    title: 'display_name'.tr(),
                    content: currentUser.displayname),
                infoItem(
                  title: 'gender'.tr(),
                  content: currentUser.gender.toLowerCase().tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoItem({String title, String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.grey),
          ),
          Text('\t$content'),
        ],
      ),
    );
  }
}
