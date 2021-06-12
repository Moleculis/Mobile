import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/auth/auth_event.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/screens/contacts/widgets/user_item.dart';
import 'package:moleculis/widgets/list_refresh.dart';

class UsersList extends StatefulWidget {
  final List<User>? users;

  const UsersList({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListRefresh(
      onRefresh: () async => authBloc.add(ReloadUserEvent()),
      isNoItems: widget.users?.isEmpty,
      noItemsText: 'no_other_users'.tr(),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final User user = widget.users![index];
          return UserItem(user: user);
        },
        itemCount: widget.users!.length,
      ),
    );
  }
}
