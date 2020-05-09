import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:moleculis/services/app_esceptions.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';

class HttpHelper {
  HttpHelper._internal() {
    httpClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
    ioClient = IOClient(httpClient);
  }

  static final HttpHelper _instance = HttpHelper._internal();

  factory HttpHelper() {
    return _instance;
  }

  SharedPrefManager _prefs = SharedPrefManager();
  HttpClient httpClient = HttpClient();
  IOClient ioClient;
  bool trustSelfSigned = true;

  final String _baseUrl = "localhost:8080";

  Map<String, String> _postHeaders = {
    'accept': 'application/json',
    'Content-Type': 'application/json; charset=utf-8',
  };

  Future<Map<String, dynamic>> get(String endpoint) async {
    var responseJson;
    try {
      final response = await ioClient.get(
        _baseUrl + endpoint,
        headers: await _getAuthTokenHeader(),
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
    String body,
    authorized = true,
  }) async {
    var responseJson;
    Map<String, String> postHeaders = _postHeaders;
    if (headers != null) {
      postHeaders.addAll(headers);
    }
    if (authorized) {
      postHeaders.addAll(await _getAuthTokenHeader());
    }
    try {
      final response = await ioClient.post(
        _baseUrl + endpoint,
        headers: postHeaders,
        body: body,
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
    String body,
    authorized = true,
  }) async {
    var responseJson;
    Map<String, String> postHeaders = _postHeaders;
    if (headers != null) {
      postHeaders.addAll(headers);
    }
    if (authorized) {
      postHeaders.addAll(await _getAuthTokenHeader());
    }
    try {
      final response = await ioClient.put(
        _baseUrl + endpoint,
        headers: postHeaders,
        body: body,
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
        headers: await _getAuthTokenHeader(),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet'.tr());
    }
    return responseJson;
  }

  Future<Map<String, String>> _getAuthTokenHeader() async {
    final accessToken = await _prefs.getAccessToken();
    return {HttpHeaders.authorizationHeader: 'Bearer $accessToken'};
  }

  Map<String, dynamic> _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            '${'server_communication_error'.tr()}: ${response.statusCode}');
    }
  }
}
