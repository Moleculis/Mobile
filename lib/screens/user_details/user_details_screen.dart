import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/auth/auth_state.dart';
import 'package:moleculis/models/enums/gender.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/screens/auth/create_edit_user_screen.dart';
import 'package:moleculis/screens/chat/chat_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/big_tile.dart';
import 'package:moleculis/widgets/info_item.dart';

class UserDetails extends StatefulWidget {
  final UserSmall? userSmall;

  const UserDetails({Key? key, this.userSmall}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late final AuthBloc authBloc;

  bool get isProfile => widget.userSmall == null;

  @override
  void initState() {
    super.initState();

    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final AuthState authState = authBloc.state;
    final User currentUser = authState.currentUser!;
    return Scaffold(
      appBar: WidgetUtils.appBar(
        context,
        title: isProfile
            ? 'personal_info'.tr().toLowerCase()
            : widget.userSmall!.displayName,
        actions: [
          if (isProfile)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                await Navigation.toScreen(
                  context: context,
                  screen: Scaffold(
                    body: CreateEditUserScreen(
                      edit: true,
                    ),
                  ),
                );
                setState(() {});
              },
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BigTile(
                  title: isProfile
                      ? currentUser.fullname
                      : widget.userSmall!.fullName,
                  subtitle: isProfile ? currentUser.username : null,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Divider(),
                ),
                infoItem(
                    title: 'email'.tr(),
                    content: isProfile
                        ? currentUser.email
                        : widget.userSmall!.email),
                infoItem(
                    title: 'username'.tr(),
                    content: isProfile
                        ? currentUser.username
                        : widget.userSmall!.username),
                infoItem(
                  title: 'gender'.tr(),
                  content: (isProfile
                          ? currentUser.gender
                          : widget.userSmall!.gender)
                      .assetName
                      .toLowerCase()
                      .tr(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigation.toScreen(
            context: context,
            screen: ChatScreen(user: widget.userSmall),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget infoItem({String? title, String? content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InfoItem(
        title: title,
        content: content,
      ),
    );
  }
}
