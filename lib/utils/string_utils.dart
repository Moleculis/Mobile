class StringUtils {
  static String getUserInitials(String? userName) {
    if (userName != null) {
      if (userName.contains(' ')) {
        final secondNameIndex = userName.indexOf(' ') + 1;
        return '${userName[0]}'
            '${userName.substring(secondNameIndex, secondNameIndex + 1)}';
      } else {
        return userName[0];
      }
    } else {
      return '';
    }
  }
}
