import 'package:base_app/src/app_env.dart';
import 'package:dio/dio.dart';

abstract class Apis {
  static const String devBaseUrl = "https://jsonplaceholder.typicode.com";
  static const String stageBaseUrl = "https://jsonplaceholder.typicode.com";
  static const String prodBaseUrl = "https://jsonplaceholder.typicode.com";
}

abstract class NetworkSvcs {
  void init();

  Future<Response<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
  });

  Future<Response<T>> post<T>({
    required String path,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
  });

  void dispose();
}

class DioNetworkSvcs implements NetworkSvcs {
  late final Dio _dio;

  @override
  void dispose() {
    _dio.close();
  }

  @override
  Future<Response<T>> get<T>(
      {required String path, Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  @override
  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: AppEnv.values.apiBaseUrl,
      connectTimeout: const Duration(seconds: 3),
    ));

    _dio.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      QueuedInterceptorsWrapper(
        onError: (error, handler) {
          // handle errors
          return handler.next(error);
        },
        onRequest: (options, handler) {
          // adding token in request when needed
          options.headers["Authorization"] = "Bearer token";
          return handler.next(options);
        },
        onResponse: (response, handler) {
          //saving token if received in secured storage
          return handler.next(response);
        },
      )
    ]);
  }

  @override
  Future<Response<T>> post<T>(
      {required String path,
      required Map<String, dynamic> body,
      Map<String, dynamic>? queryParameters}) {
    return _dio.post(path, data: body, queryParameters: queryParameters);
  }
}
