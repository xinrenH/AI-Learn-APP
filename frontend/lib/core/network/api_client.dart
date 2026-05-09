import 'package:dio/dio.dart';

import 'api_endpoints.dart';
import 'api_response.dart';

class ApiClient {
  ApiClient._();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  )
    ..interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout) {
            handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: ApiException('网络超时，请稍后重试'),
              ),
            );
            return;
          }

          if (error.response != null) {
            final status = error.response!.statusCode;
            if (status == 500) {
              handler.reject(
                DioException(
                  requestOptions: error.requestOptions,
                  error: ApiException('服务异常，请稍后重试'),
                ),
              );
              return;
            }
          }

          handler.next(error);
        },
      ),
    );
}
