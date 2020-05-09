import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';

class HttpHelper {
  HttpHelper._internal({String locale}) {
    this.locale = locale == 'uk' ? 'ua' : locale;
    httpClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
    ioClient = IOClient(httpClient);
  }

  static HttpHelper _instance;

  factory HttpHelper({String locale}) {
    if (_instance == null ||
        (_instance != null && locale != null && _instance.locale != locale)) {
      _instance = HttpHelper._internal(locale: locale);
    }
    return _instance;
  }

  SharedPrefManager _prefs = SharedPrefManager();
  HttpClient httpClient = HttpClient();
  IOClient ioClient;
  String locale;
  bool trustSelfSigned = true;

  final String _baseUrl = "http://10.0.2.2:8080";

  Map<String, String> _postHeaders = {
    'accept': 'application/json',
    'Content-Type': 'application/json; charset=utf-8',
  };

  Future<Map<String, dynamic>> get(String endpoint) async {
    var responseJson;
    try {
      final response = await ioClient.get(
        _baseUrl + endpoint,
        headers: _getAuthTokenHeader(),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, String> headers,
        Map<String, dynamic> body,
    authorized = true,
  }) async {
    var responseJson;
    Map<String, String> postHeaders = _postHeaders;
    if (headers != null) {
      postHeaders.addAll(headers);
    }
    if (authorized) {
      postHeaders.addAll(_getAuthTokenHeader());
    }
    try {
      print('Locale: $locale');
      final response = await ioClient.post(
        _baseUrl + endpoint,
        headers: postHeaders..addAll({'Accept-Language': locale}),
        body: json.encode(body),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, String> headers,
        Map<String, dynamic> body,
    authorized = true,
  }) async {
    var responseJson;
    Map<String, String> postHeaders = _postHeaders;
    if (headers != null) {
      postHeaders.addAll(headers);
    }
    if (authorized) {
      postHeaders.addAll(_getAuthTokenHeader());
    }
    try {
      final response = await ioClient.put(
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

  Future<Map<String, dynamic>> delete(String endpoint) async {
    var responseJson;
    try {
      final response = await ioClient.delete(
        _baseUrl + endpoint,
        headers: _getAuthTokenHeader(),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  Map<String, String> _getAuthTokenHeader() {
    final String accessToken = _prefs.getAccessToken();
    return {HttpHeaders.authorizationHeader: accessToken};
  }

  Map<String, dynamic> _returnResponse(Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body.toString());
    }
    throw AppException('', json.decode(response.body)['message']);
  }
}
