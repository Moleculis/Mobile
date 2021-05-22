import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_event_request.dart';
import 'package:moleculis/services/apis/events_service.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/utils/locator.dart';

class EventsServiceImpl implements EventsService {
  final HttpHelper _httpHelper = locator<HttpHelper>();
  final String _endpointBase = '/events';

  String get _createEventEndpoint => _endpointBase + '/';

  String _getEventsPageEndpoint(int page) => _endpointBase + '/page/$page';

  String _getOthersEventsPageEndpoint(int page) =>
      _endpointBase + '/others/page/$page';

  String _updateEventEndpoint(int? eventId) => _endpointBase + '/$eventId';

  String _leaveEventEndpoint(int? eventId) => _endpointBase + '/leave/$eventId';

  @override
  Future<Page> getEventsPage(int page) async {
    final response = await _httpHelper.get(_getEventsPageEndpoint(page));
    return Page.fromMap(response);
  }

  @override
  Future<Page> getOthersEventsPage(int page) async {
    final response = await _httpHelper.get(_getOthersEventsPageEndpoint(page));
    return Page.fromMap(response);
  }

  @override
  Future<String?> updateEvent(
    int? eventId,
    CreateUpdateEventRequest request,
  ) async {
    final response = await _httpHelper.put(
      _updateEventEndpoint(eventId),
      body: request.toMap(),
    );
    return response['message'];
  }

  @override
  Future<String?> createEvent(CreateUpdateEventRequest request) async {
    final response = await _httpHelper.post(
      _createEventEndpoint,
      body: request.toMap(),
    );
    return response['message'];
  }

  @override
  Future<String?> leaveEvent(int? eventId) async {
    final response = await _httpHelper.post(
      _leaveEventEndpoint(eventId),
    );
    return response['message'];
  }
}
