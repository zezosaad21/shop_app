import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
    String lang,
  }) async {

    dio.options.headers = {
      'lang' : 'ar',

    };
    return await dio.post(
      url,
      data: data,
    );
  }
}
