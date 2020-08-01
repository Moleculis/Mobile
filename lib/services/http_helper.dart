import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';

class HttpHelper {
  HttpHelper._internal({String locale}) {
    this._locale = locale == 'uk' ? 'ua' : locale;
    _httpClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => _trustSelfSigned);
    _ioClient = IOClient(_httpClient);
  }

  static HttpHelper _instance;

  factory HttpHelper({String locale}) {
    if (_instance == null ||
        (_instance != null && locale != null && _instance._locale != locale)) {
      _instance = HttpHelper._internal(locale: locale);
    }
    return _instance;
  }

  final String _baseUrl =
      "http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:8080";

  SharedPrefManager _prefs = SharedPrefManager();
  HttpClient _httpClient = HttpClient();
  IOClient _ioClient;
  String _locale;

  String get locale => _locale;
  bool _trustSelfSigned = true;

  Map<String, String> _postHeaders = {
    'accept': 'application/json',
    'Content-Type': 'application/json; charset=utf-8',
  };

  Map<String, String> get _authTokenHeader {
    final String accessToken = _prefs.getAccessToken();
    return {HttpHeaders.authorizationHeader: accessToken};
  }

  Map<String, String> get _localizationHeader =>
      {'Accept-Language': _instance.locale};

  Future<dynamic> get(String endpoint, {bool localized = true}) async {
    var responseJson;
    try {
      final Map<String, String> getHeaders = {};
      getHeaders.addAll(_authTokenHeader);
      if (localized) {
        getHeaders.addAll(_localizationHeader);
      }
      final response = await _ioClient.get(
        _baseUrl + endpoint,
        headers: _authTokenHeader,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  Future<dynamic> post(String endpoint, {
    Map<String, String> headers,
    Map<String, dynamic> body,
    authorized = true,
    bool localized = true,
  }) async {
    var responseJson;
    final Map<String, String> postHeaders = {};
    postHeaders.addAll(_postHeaders);
    if (headers != null) {
      postHeaders.addAll(headers);
    }
    if (authorized) {
      postHeaders.addAll(_authTokenHeader);
    }
    if (localized) {
      postHeaders.addAll(_localizationHeader);
    }
    try {
      final response = await _ioClient.post(
        _baseUrl + endpoint,
        headers: postHeaders,
        body: json.encode(body),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  Future<dynamic> put(String endpoint, {
    Map<String, String> headers,
    Map<String, dynamic> body,
    authorized = true,
    bool localized = true,
  }) async {
    var responseJson;
    final Map<String, String> putHeaders = {};
    putHeaders.addAll(_postHeaders);
    if (headers != null) {
      putHeaders.addAll(headers);
    }
    if (authorized) {
      putHeaders.addAll(_authTokenHeader);
    }
    if (localized) {
      putHeaders.addAll(_localizationHeader);
    }
    try {
      final response = await _ioClient.put(
        _baseUrl + endpoint,
        headers: putHeaders,
        body: json.encode(body),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  Future<dynamic> delete(String endpoint, {bool localized = true}) async {
    var responseJson;
    try {
      final Map<String, String> deleteHeaders = {};
      deleteHeaders.addAll(_authTokenHeader);
      if (localized) {
        deleteHeaders.addAll(_localizationHeader);
      }
      final response = await _ioClient.delete(
        _baseUrl + endpoint,
        headers: deleteHeaders,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body.toString());
    }
    throw AppException('', json.decode(response.body)['message']);
  }
}
