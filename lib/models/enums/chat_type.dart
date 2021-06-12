import 'package:moleculis/models/enums/enum_parser.dart';

enum ChatType { personal, group }

ChatType chatTypeFromString(String json) {
  return ChatType.values.firstWhere(
    (element) =>
        EnumParser.toStringValue(element)!.toUpperCase() == json.toUpperCase(),
  );
}
