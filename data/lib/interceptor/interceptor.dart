import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class MiddlewareInterceptor implements Interceptor {
  final SharedPreferencesRepository _repository;

  MiddlewareInterceptor({
    required SharedPreferencesRepository repository,
  }) : _repository = repository;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.response?.statusCode) {
      case 400:
        break;
      case 401:
        break;
      case 404:
        break;
      case 403:
        // TODO : Refresh Token
        break;
      case 500:
      case 502:
        break;
      case 503:
        break;
      default:
    }
  }

  void _refreshToken() async {

  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final response = await _repository.getLoginEntity();

    if (response != null) {
      options.headers = {'Authorization': 'Bearer ${response.loginEntity.accessToken}'};

      return handler.next(options);
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}
