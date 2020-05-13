import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_group_request.dart';
import 'package:moleculis/services/http_helper.dart';

class GroupsService {
  final HttpHelper _httpHelper;

  String get _endpointBase => '/groups';

  String get _createGroupEndpoint => _endpointBase + '/';

  String _getGroupsPageEndpoint(int page) => _endpointBase + '/page/$page';

  String _getOtherGroupsPageEndpoint(int page) =>
      _endpointBase + '/other/page/$page';

  GroupsService(this._httpHelper);

  Future<Page> getGroupsPage(int page) async {
    final response = await _httpHelper.get(_getGroupsPageEndpoint(page));
    return Page.fromMap(response);
  }

  Future<Page> getOtherGroupsPage(int page) async {
    final response = await _httpHelper.get(_getOtherGroupsPageEndpoint(page));
    return Page.fromMap(response);
  }

  Future<String> createGroup(CreateUpdateGroupRequest request) async {
    final response = await _httpHelper.post(
      _createGroupEndpoint,
      body: request.toMap(),
    );
    return response['message'];
  }
}
