import 'package:dio/dio.dart';

class ApiException implements Exception {
  ApiException(this.message, {this.code});

  final String message;
  final int? code;

  @override
  String toString() => message;
}

class ApiResponseParser {
  static Map<String, dynamic> requireData(Response response) {
    final raw = response.data;
    if (raw is! Map<String, dynamic>) {
      throw ApiException('响应格式错误');
    }

    final code = raw['code'];
    final message = raw['message'];
    final data = raw['data'];

    if (code is! int) {
      throw ApiException('响应缺少状态码');
    }

    if (code != 0) {
      throw ApiException(
        message is String ? message : '请求失败',
        code: code,
      );
    }

    if (data is! Map<String, dynamic>) {
      throw ApiException('响应数据格式错误');
    }

    return data;
  }
}
