import 'package:moleculis/models/page.dart';
import 'package:moleculis/models/requests/create_update_event_request.dart';

abstract class EventsService {
  Future<Page> getEventsPage(int page);

  Future<Page> getOthersEventsPage(int page);

  Future<String?> updateEvent(
    int eventId,
    CreateUpdateEventRequest request,
  );

  Future<String?> createEvent(CreateUpdateEventRequest request);

  Future<String?> leaveEvent(int eventId);
}
