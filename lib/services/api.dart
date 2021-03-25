import 'dart:convert';
import 'package:hashbot/constants/constants.dart';
import 'package:dio/dio.dart';

class Api {
  static Api _instance = Api.internal();
  Api.internal();
  factory Api() => _instance;

  final baseUrl = R.baseUrl;
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> post(reqType, query) async {
    Map data = {
      "req": reqType,
      "query": query,
    };

    return Dio().post(baseUrl, data: data).then((response) {
      final String res = response.data;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> get() async {
    return Dio().get(baseUrl).then((response) {
      final String res = response.data;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}
