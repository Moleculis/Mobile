import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  SharedPrefManager._internal();

  static final SharedPrefManager _instance = SharedPrefManager._internal();

  factory SharedPrefManager() {
    return _instance;
  }

  SharedPreferences prefs;
  final String accessTokenKey = 'access_token_key';
  final String accessTokenExpirationDateKey = 'access_token_expiration_key';

  Future<void> saveAccessToken(String accessToken, int expireDate) async {
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setInt(accessTokenExpirationDateKey, expireDate);
  }

  String getAccessToken() {
    return 'Bearer ${prefs.getString(accessTokenKey)}';
  }

  Future<bool> isAuthenticated() async {
    prefs = await SharedPreferences.getInstance();

    bool isAuthenticated = false;
    if (getAccessToken() != 'Bearer null') {
      final int expirationDate = prefs.getInt(accessTokenExpirationDateKey);
      final int expireIn =
          expirationDate - DateTime.now().millisecondsSinceEpoch;

      if (expireIn > 0) {
        isAuthenticated = true;
      }
    }
    return isAuthenticated;
  }

  Future<bool> clear() async {
    if (prefs != null) {
      return prefs.clear();
    }
    return true;
  }
}
