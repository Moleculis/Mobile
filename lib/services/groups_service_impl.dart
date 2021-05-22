import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_group_request.dart';
import 'package:moleculis/services/apis/groups_service.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/utils/locator.dart';

class GroupsServiceImpl implements GroupsService {
  final HttpHelper _httpHelper = locator<HttpHelper>();

  String get _endpointBase => '/groups';

  String get _createGroupEndpoint => _endpointBase + '/';

  String _getGroupsPageEndpoint(int page) => _endpointBase + '/page/$page';

  String _getOtherGroupsPageEndpoint(int page) =>
      _endpointBase + '/other/page/$page';

  String _updateGroupEndpoint(int? groupId) => _endpointBase + '/$groupId';

  @override
  Future<Page> getGroupsPage(int page) async {
    final response = await _httpHelper.get(_getGroupsPageEndpoint(page));
    return Page.fromMap(response);
  }

  @override
  Future<Page> getOtherGroupsPage(int page) async {
    final response = await _httpHelper.get(_getOtherGroupsPageEndpoint(page));
    return Page.fromMap(response);
  }

  @override
  Future<String?> createGroup(CreateUpdateGroupRequest request) async {
    final response = await _httpHelper.post(
      _createGroupEndpoint,
      body: request.toMap(),
    );
    return response['message'];
  }

  @override
  Future<String?> updateGroup(
    int groupId,
    CreateUpdateGroupRequest request,
  ) async {
    final response = await _httpHelper.put(
      _updateGroupEndpoint(groupId),
      body: request.toMap(),
    );
    return response['message'];
  }
}
