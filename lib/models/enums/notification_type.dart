import 'package:moleculis/models/enums/enum_parser.dart';

enum NotificationType {
  newPersonalChatMessage,
  newGroupChatMessage,
  newEvent,
  newGroup,
}

NotificationType notificationTypeFromString(String json) {
  return NotificationType.values.firstWhere(
        (element) =>
    EnumParser.toStringValue(element)!.toUpperCase() ==
        json.toUpperCase(),
  );
}
