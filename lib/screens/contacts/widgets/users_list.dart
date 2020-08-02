import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_bloc.dart';
import 'package:moleculis/blocs/authentication/authentication_event.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/screens/contacts/widgets/user_item.dart';
import 'package:moleculis/widgets/list_refresh.dart';

class UsersList extends StatefulWidget {
  final List<User> users;

  const UsersList({
    Key key,
    @required this.users,
  }) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  AuthenticationBloc authenticationBloc;

  @override
  void didChangeDependencies() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListRefresh(
      onRefresh: () async => authenticationBloc.add(LoadInitialData()),
      isNoItems: widget.users?.isEmpty,
      noItemsText: 'no_other_users'.tr(),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final User user = widget.users[index];
          return UserItem(user: user);
        },
        itemCount: widget.users.length,
      ),
    );
  }
}
