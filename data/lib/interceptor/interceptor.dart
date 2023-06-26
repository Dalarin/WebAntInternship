import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

import '../data.dart';

class MiddlewareInterceptor implements Interceptor {
  final SharedPreferencesRepository _repository;
  final RefreshTokenRepository _refreshRepository;

  MiddlewareInterceptor({
    required SharedPreferencesRepository repository,
    required RefreshTokenRepository refreshRepository,
  })  : _repository = repository,
        _refreshRepository = refreshRepository;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print(err.response?.statusCode);

    print(err.response?.data);

    switch (err.response?.statusCode) {
      case 400:
        handler.reject(BadRequest(requestOptions: err.requestOptions));
        break;
      case 401:
      case 403:
        await _refreshToken(err.requestOptions, handler);
        break;
      case 404:
        handler.reject(NotFound(requestOptions: err.requestOptions));
        break;
      case 500:
      case 502:
        handler.reject(ServerUnavailable(requestOptions: err.requestOptions));
        break;
      case 503:
        handler.reject(ServiceTemporarilyUnavailable(requestOptions: err.requestOptions));
        break;
      default:
        handler.reject(UnknownError(requestOptions: err.requestOptions));
    }
  }

  Future<void> _refreshToken(RequestOptions options, ErrorInterceptorHandler handler) async {
    final response = await _repository.getLoginEntity();

    print(response);

    if (response != null) {
      final tokenResponse = await _refreshRepository.refreshToken(entity: response);

      print('Refresh token : $tokenResponse');

      if (tokenResponse != null) {
        _repository.saveLoginEntity(
          entity: response.copyWith(
            loginEntity: tokenResponse,
          ),
        );

        options.headers = {'Authorization': 'Bearer ${tokenResponse.refreshToken}'};

        final newRequest = await Dio().request(
          '${options.baseUrl}${options.path}',
          data: options.data,
          queryParameters: options.queryParameters,
          cancelToken: options.cancelToken,
          onReceiveProgress: options.onReceiveProgress,
          onSendProgress: options.onSendProgress,
        );

        if (newRequest != null) {
          return handler.resolve(newRequest);
        }

        return handler.reject(Unauthorized(requestOptions: options));
      } else {
        handler.reject(Unauthorized(requestOptions: options));
      }
    }
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
