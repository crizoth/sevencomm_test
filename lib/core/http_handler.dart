import 'package:dio/dio.dart';

class HttpHandler {
  final String baseUrl;
  late Dio _dio;

  HttpHandler({required this.baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    ));

    _dio.interceptors.add(LogInterceptor());
  }

  Future<Response> post({required String url, dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> get(
      {required String url, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> put({required String url, required dynamic data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> delete({required String url, dynamic data}) async {
    try {
      final response = await _dio.delete(url, data: data);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}

class LogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('');
    print('=====================================');
    print('---Request---');
    print('Method: ${options.method}');
    print('URL: ${options.baseUrl}${options.path}');
    if (options.queryParameters.isNotEmpty) {
      print('Query Params: ${options.queryParameters}');
    }
    if (options.data != null) {
      print('Data: ${options.data}');
    }
    print('=====================================');
    print('');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('');
    print('=====================================');
    print('---Response---');
    print(
        'Url: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    print('Status Code: ${response.statusCode}');
    print(
        'URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
    print('Data: ${response.data.toString()}');
    print('=====================================');
    print('');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('');
    print('=====================================');
    print('---Error---');
    if (err.response != null) {
      print('Url: ${err.requestOptions.baseUrl}${err.requestOptions.path}');
      print('Status Code: ${err.response?.statusCode}');
      print('Data: ${err.response?.data.toString()}');
    } else {
      print('Message: ${err.message}');
    }
    print('=====================================');
    print('');
    super.onError(err, handler);
  }
}
