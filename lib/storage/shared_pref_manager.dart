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
    await _initPrefs();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setInt(accessTokenExpirationDateKey, expireDate);
  }

  Future<String> getAccessToken() async {
    await _initPrefs();
    return await prefs.getString(accessTokenKey);
  }

  Future<bool> isAuthenticated() async {
    await _initPrefs();
    bool isAuthenticated = false;
    if (await getAccessToken() != null) {
      final int expirationDate =
          await prefs.getInt(accessTokenExpirationDateKey);

      int expireIn = expirationDate - DateTime.now().millisecondsSinceEpoch;

      if (expireIn > 0) {
        isAuthenticated = true;
      }
    }

    return isAuthenticated;
  }

  Future<void> _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  Future<bool> clear() async {
    if (prefs != null) {
      return prefs.clear();
    }
    return true;
  }
}
