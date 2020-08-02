import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/screens/user_details/user_details_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return SimpleTile(
      onTap: () {
        Navigation.toScreen(
          context: context,
          screen: UserDetails(
            userSmall: UserSmall.fromUser(user),
          ),
        );
      },
      title: user.displayname,
      subtitle: user.username,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              authBloc.add(SendContactRequestEvent(user.username));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.add,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
