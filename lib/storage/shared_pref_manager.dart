import 'package:flutter/cupertino.dart';
import 'package:moleculis/utils/locale_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  late final SharedPreferences _prefs;
  final String currentLanguageKey = 'current_lang';
  final String accessTokenKey = 'access_token';
  final String accessTokenExpirationDateKey = 'access_token_expiration';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get authenticated {
    bool isAuthenticated = false;
    if (_prefs.getString(accessTokenKey) != null) {
      final int expirationDate = _prefs.getInt(accessTokenExpirationDateKey)!;
      final int expireIn =
          expirationDate - DateTime.now().millisecondsSinceEpoch;

      if (expireIn > 0) isAuthenticated = true;
    }
    return isAuthenticated;
  }

  String get accessToken => 'Bearer ${_prefs.getString(accessTokenKey)}';

  Future<void> saveAccessToken(String accessToken, int expireDate) async {
    await _prefs.setString(accessTokenKey, accessToken);
    await _prefs.setInt(accessTokenExpirationDateKey, expireDate);
  }

  Future<void> saveCurrentLocale(Locale locale) async {
    await _prefs.setString(currentLanguageKey, locale.languageCode);
  }

  Locale get currentLocale =>
      LocaleUtils.localeFromCode(_prefs.getString(currentLanguageKey));

  Future<void> clear() async => await _prefs.clear();
}
