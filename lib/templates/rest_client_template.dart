class RestClientTemplate {
  // RestClient Interface
  static const String restClientInterface = '''
  import 'rest_client_response.dart';

  abstract class RestClient {
    RestClient auth();
    RestClient unauth();

    Future<RestClientResponse<T>> post<T>(
      String path,
      {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }
    );

    Future<RestClientResponse<T>> get<T>(
      String path,
      {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }
    );

    Future<RestClientResponse<T>> put<T>(
      String path,
      {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }
    );

    Future<RestClientResponse<T>> delete<T>(
      String path,
      {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }
    );

    Future<RestClientResponse<T>> patch<T>(
      String path,
      {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }
    );
  }
''';

  // RestClient Response
  static const String restClientResponse = '''
  class RestClientResponse<T> {
    T? data;
    int? statusCode;
    String? message;
    String? token;

    RestClientResponse({
      this.data,
      this.statusCode,
      this.message,
      this.token,
    });
  }
''';

  // RestClient Exception
  static const String restClientException = '''
  import 'rest_client_response.dart';

  class RestClientException implements Exception {
    String? message;
    int? statusCode;
    dynamic error;
    RestClientResponse response;

    RestClientException({
      this.message,
      this.statusCode,
      required this.error,
      required this.response,
    });

    @override
    String toString() {
      return 'RestClientException{message: \$message, statusCode: \$statusCode, error: \$error, response: \$response}';
    }
  }
''';

  // Dio RestClient Implementation
  static const String dioRestClient = '''
  import 'package:dio/dio.dart';
  import '../rest_client.dart';
  import '../rest_client_response.dart';
  import '../rest_client_exception.dart';

  class DioRestClient implements RestClient {
    final Dio _dio;

    DioRestClient({
      BaseOptions? options,
    }) : _dio = Dio(options);

    @override
    RestClient auth() {
      return this;
    }

    @override
    RestClient unauth() {
      return this;
    }

    @override
    Future<RestClientResponse<T>> delete<T> (
      String path,
      {
        data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,  
      }
    ) async {
      try {
        final response = await _dio.delete<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioException catch (e) {
        throw _throwRestClientException(e);
      }
    }

    @override
    Future<RestClientResponse<T>> get<T> (
      String path,
      {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }
    ) async {
      try {
        final response = await _dio.get<T>(
          path,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioException catch (e) {
        throw _throwRestClientException(e);
      }
    }

    @override
    Future<RestClientResponse<T>> post<T> (
      String path,
      {
        data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }
    ) async {
      try {
        final response = await _dio.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioException catch (e) {
        throw _throwRestClientException(e);
      }
    }

    @override
    Future<RestClientResponse<T>> put<T> (
      String path,
      {
        data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }
    ) async {
      try {
        final response = await _dio.put<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioException catch (e) {
        throw _throwRestClientException(e);
      }
    }

    @override
    Future<RestClientResponse<T>> patch<T> (
      String path,
      {
        data,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
      }
    ) async {
      try {
        final response = await _dio.patch<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );

        return _dioResponseConverter(response);
      } on DioException catch (e) {
        throw _throwRestClientException(e);
      }
    }

    Future<RestClientResponse<T>> _dioResponseConverter<T>(Response<T> response) async {
      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }

    Never _throwRestClientException(DioException e) {
      throw RestClientException(
        message: e.message,
        statusCode: e.response?.statusCode,
        error: e.error,
        response: RestClientResponse(
          data: e.response?.data,
          statusCode: e.response?.statusCode,
          message: e.response?.statusMessage,
        ),
      );
    }
  }
''';

  // Interceptors básicos
  static const String authInterceptor = '''
  import 'package:dio/dio.dart';

  class AuthInterceptor extends Interceptor {
    @override
    void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
      options.headers['Authorization'] = 'Bearer <token>';
      super.onRequest(options, handler);
    }
  }
''';
}
