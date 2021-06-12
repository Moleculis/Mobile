import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_group_request.dart';

abstract class GroupsService {
  Future<Page> getGroupsPage(int page);

  Future<Page> getOtherGroupsPage(int page);

  Future<String?> createGroup(CreateUpdateGroupRequest request);

  Future<String?> updateGroup(
    int groupId,
    CreateUpdateGroupRequest request,
  );
}
