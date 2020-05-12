import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_event_request.dart';
import 'package:moleculis/services/http_helper.dart';

class EventsService {
  final HttpHelper _httpHelper;
  final String _endpointBase = '/events';

  String get _createEventEndpoint => _endpointBase + '/';

  String _getEventsPageEndpoint(int page) => _endpointBase + '/page/$page';

  String _getOthersEventsPageEndpoint(int page) =>
      _endpointBase + '/others/page/$page';

  String _updateEventEndpoint(int eventId) => _endpointBase + '/$eventId';

  EventsService(this._httpHelper);

  Future<Page> getEventsPage(int page) async {
    final response = await _httpHelper.get(_getEventsPageEndpoint(page));
    return Page.fromMap(response);
  }

  Future<Page> getOthersEventsPage(int page) async {
    final response = await _httpHelper.get(_getOthersEventsPageEndpoint(page));
    return Page.fromMap(response);
  }

  Future<String> updateEvent(int eventId,
      CreateUpdateEventRequest request) async {
    final response = await _httpHelper.put(
      _updateEventEndpoint(eventId),
      body: request.toMap(),
    );
    return response['message'];
  }

  Future<String> createEvent(CreateUpdateEventRequest request) async {
    final response = await _httpHelper.post(
      _createEventEndpoint,
      body: request.toMap(),
    );
    return response['message'];
  }
}
