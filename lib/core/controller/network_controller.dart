import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_prac/core/utils/enums/enums.dart';
import 'package:flutter_bloc_prac/core/utils/logger/pretty_logger.dart';
import 'package:flutter_bloc_prac/features/social/data/config/api_endpoints.dart';
import 'package:flutter_bloc_prac/features/social/data/repositories/api_response.dart';
import 'package:flutter_bloc_prac/features/social/data/response/success_response.dart';

import '../../features/social/data/response/failure_response.dart';

class NetworkController with PrettyLogger {
  static NetworkController? _instance;
  Dio? _dio;
  String? _accessToken;
  String? _refreshToken;
  bool failedReauthentication = false;

  NetworkController._(String baseUrl) {
    init(baseUrl);
  }

  factory NetworkController.init({required String baseUrl}) =>
      _instance ??= NetworkController._(baseUrl);

  static NetworkController get instance => _instance!;

  void init(String baseUrl) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: "application/json",
        persistentConnection: true,
        connectTimeout: const Duration(seconds: 16),
        receiveTimeout: const Duration(seconds: 16),
        sendTimeout: const Duration(seconds: 16),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    _initInterceptor();
  }

  set setAccessToken(String accessToken) => _accessToken = accessToken;

  set setRefreshToken(String refreshToken) => _refreshToken = refreshToken;

  Map<String, String> _getHeader(String? token) {
    return {"Accept": "application/json", "Authorization": "Bearer $token"};
  }

  Options _getOptions({bool isMedia = false}) {
    return Options(
      headers: _getHeader(_accessToken),
      responseType: ResponseType.json,
      contentType: isMedia ? "multipart/form-data" : "application/json",
    );
  }

  void _initInterceptor() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          infoLogger(
            message:
                "Request: ${options.method} ${options.baseUrl}${options.path}",
          );
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          infoLogger(
            message:
                "Request: ${response.requestOptions.method} ${response.requestOptions.baseUrl}${response.requestOptions.path}",
          );
          if (response.statusCode == 401 && _accessToken != null) {
            if (failedReauthentication) {
              return handler.next(response);
            }
            // bool isTokenRefreshed = !await _refreshAccessToken();
            // if(isTokenRefreshed){
            //   await _syncToken();
            //   return handler.resolve(await _retryRequest(response.requestOptions));
            // }
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          infoLogger(
            message:
                "Request: ${error.requestOptions.method} ${error.requestOptions.baseUrl}${error.requestOptions.path}",
          );
          return handler.next(error);
        },
      ),
    );
  }

  Future<ApiResponse> request({
    required RequestMethod requestMethod,
    required String endpoint,
    Map<String, dynamic>? params,
    bool isMediaUpload = false,
  }) async {
    try {
      infoLogger(message: "Request Params: $params");
      final Response response = await _performHttpRequest({
        'requestMethod': requestMethod,
        'endpoint': endpoint,
        'params': params,
        'isMedia': isMediaUpload,
      });
      late ApiResponse apiResponse;
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        apiResponse = SuccessResponse(data: response.data);
        infoLogger(message: (apiResponse as SuccessResponse).data);
      } else {
        apiResponse = FailureResponse(
          statusCode: response.statusCode,
          message: response.statusMessage,
        );
      }
      return apiResponse;
    } on SocketException catch (exception) {
      errorLogger(message: exception);
      throw Exception("Network connectivity issue");
    } on FormatException catch (exception) {
      errorLogger(message: exception);
      throw Exception("Bad response format");
    } catch (exception, stacktrace) {
      errorLogger(message: exception, stackTrace: stacktrace);
      throw Exception("Something went wrong");
    }
  }

  Future<Response> _performHttpRequest(Map<String, dynamic> payload) async {
    final String endpoint = payload['endpoint'];
    final RequestMethod requestMethod = payload['requestMethod'];
    final Map<String, dynamic>? params = payload['params'];
    final bool isMedia = payload['isMedia'];
    try {
      Response response;

      switch (requestMethod) {
        case RequestMethod.get:
          response = await _dio!.get(
            endpoint,
            queryParameters: params,
            options: _getOptions(isMedia: isMedia),
          );
          break;
        case RequestMethod.post:
          response = await _dio!.post(
            endpoint,
            data: params,
            options: _getOptions(isMedia: isMedia),
          );
          break;
        case RequestMethod.put:
          response = await _dio!.put(
            endpoint,
            data: params,
            options: _getOptions(),
          );
          break;
        case RequestMethod.delete:
          response = await _dio!.delete(
            endpoint,
            queryParameters: params,
            options: _getOptions(),
          );
          break;

        case RequestMethod.patch:
          response = await _dio!.patch(
            endpoint,
            data: params,
            options: _getOptions(),
          );
          break;
      }
      return response;
    } catch (exception, stacktrace) {
      errorLogger(message: exception, stackTrace: stacktrace);
      throw Exception("Exception from performHttpRequest");
    }
  }

  /// This method fetches new token from the server when it encounters [401] error
  Future<bool> _refreshAccessToken() async {
    failedReauthentication = true;
    try {
      debugLogger(message: "Refresh token $_refreshToken");
      final Response response = await _dio!.post(
        ApiEndpoints.token,
        data: {"refreshToken": _refreshToken},
      );
      if (response.statusCode == 200) {
        _accessToken = response.data['accessToken'];
        _refreshToken = response.data['refreshToken'];
        infoLogger(message: "Token refreshed. New Token: $_accessToken");
        failedReauthentication = false;
        return failedReauthentication;
      } else {
        _accessToken = null;
        _refreshToken = null;
      }
      infoLogger(message: "Failed to refresh token");
    } catch (exception) {
      errorLogger(message: "Token refresh error: $exception");
    }
    return failedReauthentication;
  }
}
