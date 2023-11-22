import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../app/logic/app_settings.dart';

import '../../../../injection.dart';

import '../database/database_manager.dart';
import 'http_methods.dart';

abstract class HttpManager {
  Future<Response> request({
    required String path,
    required HttpMethods method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? payload,
  });
}

class HttpManagerImpl implements HttpManager {
  late final Dio _dio;
  late final Dio _authDio;
  late final DatabaseManager _databaseManager;

  HttpManagerImpl({
    required BaseOptions baseOptions,
    required DatabaseManager databaseManager,
  }) {
    initHttpManager(
      baseOptions: baseOptions,
      databaseManager: databaseManager,
    );
  }

  Future<void> initHttpManager({
    required BaseOptions baseOptions,
    required DatabaseManager databaseManager,
  }) async {
    _dio = Dio(baseOptions);
    _authDio = Dio(baseOptions);
    _databaseManager = databaseManager;

    _authDio.interceptors.addAll([
      _setBaseUrlInterceptor(),
      _logInterceptor(),
    ]);

    _dio.interceptors.addAll([
      _setBaseUrlInterceptor(),
      _logInterceptor(),
    ]);

    final bool isConnected =
        serviceLocator<AppSettings>().hasConnection ?? false;
  }

  @override
  Future<Response> request({
    required String path,
    required HttpMethods method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? payload,
  }) async {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }

    print("headers# ${method}");

    if (params != null) {
      _dio.options.queryParameters.addAll(params);
    }

    switch (method) {
      case HttpMethods.Get:
        return _dio.get(path);
      case HttpMethods.Post:
        return _dio.post(path, data: payload);
      case HttpMethods.Put:
        return _dio.put(path, data: payload);
      case HttpMethods.Delete:
        return _dio.delete(path);
    }
  }
}

extension HttpManagerImplHelpers on HttpManagerImpl {
  InterceptorsWrapper _setBaseUrlInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        options?.headers.addAll({
          'Authorization':
              'Bearer ${serviceLocator<DatabaseManager>().getData("token")}'
        });
        options.baseUrl = serviceLocator<AppSettings>().apiBaseUrl ??
            "https://6368df0228cd16bba70ea475.mockapi.io";

        debugPrint(
          'Call: => BASE: ${options.baseUrl}',
        );

        return handler.next(options);
      },
    );
  }

  InterceptorsWrapper _logInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint(
          'Call: => PATH: ${options.path}',
        );
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        );
        return handler.next(response);
      },
      onError: (DioError err, handler) async {
        debugPrint(
          'ERROR[${err.response?.statusCode ?? 0}] => PATH: ${err.message}',
        );

        return handler.next(err);
      },
    );
  }
}
