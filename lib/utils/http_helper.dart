import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/utils.dart';
import 'package:picapool/utils/auth_utils.dart';
import 'package:picapool/utils/logger_helper.dart';


// or new Dio with a BaseOptions instance.
Future<Dio> getDio() async {
  final String? token = getToken('accessToken');
  final BaseOptions options = BaseOptions(
    // baseUrl: 'https://www.xx.com/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    contentType: 'application/json',
  );
  final Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        if (kDebugMode) logger.printError(info: dio2curl(options));
        // Do something before request is sent
        return handler.next(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      },
      onResponse:
          (Response<dynamic> response, ResponseInterceptorHandler handler) {
        // if (kDebugMode) logger.d(dio2curl(response.requestOptions));
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        logger.printError(info: e.toString());
        // if (kDebugMode) logger.d(dio2curl(e.requestOptions));
        // Do something with response error
        return handler.next(e); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      },
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
      ),
    );
  }
  if (token != null) {
    dio.options.headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }
  return dio;
}

// A simple utility function to dump `curl` from "Dio" requests
String dio2curl(RequestOptions requestOption) {
  String curl = '';
  final StringBuffer buffer = StringBuffer();

  try {
    // Add PATH + REQUEST_METHOD
    curl +=
        "curl --request ${requestOption.method} ${requestOption.baseUrl}${requestOption.path}'";

    // Include headers
    for (final String key in requestOption.headers.keys) {
      buffer.write(curl += " -H '$key: ${requestOption.headers[key]}'");
    }

    // Include data if there is data
    if (requestOption.data != null) {
      curl += " --data-binary '${json.encode(requestOption.data)}'";
    }
    curl += ' --insecure'; //bypass https verification
  } catch (e) {
    logger.printError(info: e.toString());
  }
  return curl;
}
