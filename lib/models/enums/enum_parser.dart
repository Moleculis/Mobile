class EnumParser {
  static String? toStringValue<T>(T enumValue) {
    if (enumValue == null) return null;
    return enumValue.toString().split('.').last;
  }
}
