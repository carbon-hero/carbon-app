import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/shared_preference_helper.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/screens/authentication/login.dart';

import '../helper/navigation.dart';
import 'api_response.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute * 5;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute * 5;

extension DioErrorX on DioError {
  bool get isNoConnectionError =>
      type == DioErrorType.other &&
          error is SocketException; // import 'dart:io' for SocketException
}

class RestApiService {
  late Dio? _dio;

  factory RestApiService() => instance;

  RestApiService._() {
    initializeClient();
  }

  static final RestApiService instance = RestApiService._();

  Future<bool> initializeClient() async {
    _dio = Dio();
    _dio?.options.baseUrl = Constants.baseUrl;
    _dio?.options.connectTimeout = _defaultConnectTimeout;
    _dio?.options.receiveTimeout = _defaultReceiveTimeout;
    _dio?.httpClientAdapter;
    if (kDebugMode) {
      _dio?.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: true,
          request: false,
          requestBody: true));
    }
    _dio?.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options); //modify your request
    }, onError: (DioError e, handler) async {
      if (e.response != null) {
        if (e.response?.statusCode != 200) {
          return;
        } else {
          handler.next(e);
        }
      } else {
        handler.next(e);
      }
    }));
    return true;
  }

  Future<ApiResponse> post(
      String endPoint, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    String? token = SharedPref.pref!.getString(Preferences.token);
    try {
      var response = await _dio?.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiResponse(
          statusCode: response!.data['statusCode'],
          errors: response.data['errors'],
          data: response.data['data'],
          message: response.data['message']);
    } on DioError catch (e) {
      String errorMsg = "";
      int statusCode = 0;
      if (e.isNoConnectionError) {
        errorMsg = "no internet connection";
      } else if (e.response?.data != null) {
        errorMsg = e.response?.data["Errors"];
        statusCode = e.response?.data["StatusCode"];
      } else {
        errorMsg = e.message ?? "";
        statusCode = 0;
      }
      return ApiResponse(message: errorMsg, statusCode: statusCode);
    } catch (e) {
      String errorMsg = "";
      int statusCode = 0;
      return ApiResponse(message: errorMsg, statusCode: statusCode);
    }
  }

  Future<ApiResponse> get(
      String endPoint, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    String? token = SharedPref.pref!.getString(Preferences.token);
    try {
      var response = await _dio?.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiResponse(
          statusCode: response!.data['statusCode'],
          errors: response.data['errors'],
          data: response.data['data'],
          message: response.data['message']);
    } on DioError catch (e) {
      String errorMsg = "";
      int statusCode = 0;
      if (e.isNoConnectionError) {
        errorMsg = "no internet connection";
      } else if (e.response?.data != null) {
        errorMsg = e.response?.data["Errors"];
        statusCode = e.response?.data["StatusCode"];
      } else {
        errorMsg = e.message ?? "";
        statusCode = 0;
      }
      return ApiResponse(message: errorMsg, statusCode: statusCode);
    } catch (e) {
      String errorMsg = "";
      int statusCode = 0;
      return ApiResponse(message: errorMsg, statusCode: statusCode);
    }
  }

  Future<ApiResponse> postMultipart(
      String endPoint, {
        required String? type,
        required String? file,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    String? token = SharedPref.pref!.getString(Preferences.token);
    try {

      String fileName = file!.split('/').last;
      Map<String, dynamic> data = {"Type": type};
      data["File"] = await MultipartFile.fromFile(file, filename: fileName);
      data["Type"] = type;

      FormData formData = FormData.fromMap(data);


      var response = await _dio?.post(
        endPoint,
        data: formData,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return ApiResponse(
          statusCode: response!.data['statusCode'],
          errors: response.data['errors'],
          data: response.data['data'],
          message: response.data['message']);
    } on DioError catch (e) {
      String errorMsg = "";
      int statusCode = 0;
      if (e.isNoConnectionError) {
        errorMsg = "no internet connection";
      } else if (e.response?.data != null) {
        errorMsg = e.response?.data["Errors"];
        statusCode = e.response?.data["StatusCode"];
      } else {
        errorMsg = e.message ?? "";
        statusCode = 0;
      }
      return ApiResponse(message: errorMsg, statusCode: statusCode);
    } catch (e) {
      String errorMsg = "";
      int statusCode = 0;
      return ApiResponse(message: errorMsg, statusCode: statusCode);
    }
  }


}
