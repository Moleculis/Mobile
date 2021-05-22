import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/screens/user_details/user_details_screen.dart';
import 'package:moleculis/utils/navigation.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class UsersList extends StatelessWidget {
  final List<UserSmall> users;
  final bool editing;
  final bool showCurrentUser;
  final VoidCallback? onStateChane;

  const UsersList({
    Key? key,
    required this.users,
    this.editing = false,
    this.onStateChane,
    this.showCurrentUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = BlocProvider.of<AuthBloc>(context).state.currentUser!;
    final List<UserSmall> participants = !showCurrentUser
        ? users
            .where((element) => element.username != currentUser.username)
            .toList()
        : users;
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
          trailing: editing
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    users.remove(user);
                    onStateChane!();
                  },
                )
              : null,
        );
      },
      itemCount: participants.length,
    );
  }
}
