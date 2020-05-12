import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/models/user/user.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/services/user_service.dart';
import 'package:moleculis/widgets/simple_tile.dart';

class UserSearch extends SearchDelegate<User> {
  final List<String> excludeUsername;

  UserSearch({@required this.excludeUsername});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return _searchStream;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _searchStream;
  }

  Widget get _searchStream {
    return FutureBuilder<List<User>>(
        future: UserService(HttpHelper()).getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<User> filteredResults = snapshot.data
              .where((element) => !excludeUsername.contains(element.username))
              .toList();

          List<User> searchResults = filteredResults.where((User user) {
            return '${user.displayname} '
                    '${user.fullname} '
                    '${user.email} '
                    '${user.username}'
                .toLowerCase()
                .contains(query.toLowerCase());
          }).toList();
          if (searchResults.isEmpty) {
            return Center(
              child: Text('no_res_found'.tr()),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(30),
            itemCount: searchResults.length,
            itemBuilder: (BuildContext context, int index) {
              User user = searchResults[index];
              return SimpleTile(
                title: user.displayname,
                subtitle: user.username,
                onTap: () {
                  close(context, user);
                },
              );
            },
          );
        });
  }
}
