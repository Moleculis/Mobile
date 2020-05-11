import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/screens/user_details/user_details_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class UsersList extends StatelessWidget {
  final List<UserSmall> users;

  const UsersList({
    Key key,
    @required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UserSmall> participants = users
        .where(
          (element) =>
              element.username !=
              BlocProvider.of<AuthenticationBloc>(context)
                  .state
                  .currentUser
                  .username,
        )
        .toList();
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final UserSmall user = participants[index];
        return SimpleTile(
          onTap: () {
            Navigation.toScreen(
              context: context,
              screen: UserDetails(
                userSmall: user,
              ),
            );
          },
          title: user.displayName,
          subtitle: user.username,
        );
      },
      itemCount: participants.length,
    );
  }
}
