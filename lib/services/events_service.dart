import 'package:moleculis/models/page.dart';
import 'package:moleculis/services/http_helper.dart';

class EventsService {
  final HttpHelper _httpHelper;
  final String _endpointBase = '/events';

  String _getEventsPageEndpoint(int page) => _endpointBase + '/page/$page';

  String _getOthersEventsPageEndpoint(int page) =>
      _endpointBase + '/others/page/$page';

  EventsService(this._httpHelper);

  Future<Page> getEventsPage(int page) async {
    final response = await _httpHelper.get(_getEventsPageEndpoint(page));
    return Page.fromMap(response);
  }

  Future<Page> getOthersEventsPage(int page) async {
    final response = await _httpHelper.get(_getOthersEventsPageEndpoint(page));
    return Page.fromMap(response);
  }
}
