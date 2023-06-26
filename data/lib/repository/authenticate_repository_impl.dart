import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class AuthenticateRepositoryImpl implements AuthenticateRepository {
  final Dio _dio;

  AuthenticateRepositoryImpl(Dio dio) : _dio = dio;

  @override
  Future<LoginWrapperEntity?> authenticateWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    // Get token

    // Какой - то кринж
    final tokenResponse = await _dio.get(
      '/clients',
      queryParameters: {'limit': 15000},
    );

    if (tokenResponse.statusCode == 200) {
      final clientsWrapper = PaginatedWrapperEntity<ClientEntity>.fromJson(
        tokenResponse.data,
        (Object? json) {
          return ClientEntity.fromJson(json as Map<String, dynamic>);
        },
      );

      final client = clientsWrapper.data.where((element) => element.name == username).first;

      print(client);

      final response = await Dio().get(
        'https://gallery.prod1.webant.ru/oauth/v2/token',
        queryParameters: {
          'client_id': '${client.id}_${client.randomId}',
          'grant_type': 'password',
          'username': username,
          'password': password,
          'client_secret': client.secret,
        },
      );

      print('STATUS CODE: _______________________');

      print(response.statusCode);

      print(response.data);

      if (response.statusCode == 200) {
        final userResponse = await _dio.get(
          '/users',
          queryParameters: {'limit': 15000},
        );

        if (userResponse.statusCode == 200) {
          final userEntity = PaginatedWrapperEntity<UserEntity>.fromJson(
            userResponse.data,
            (Object? json) {
              return UserEntity.fromJson(
                json as Map<String, dynamic>,
              );
            },
          ).data.where((element) => element.email == username).first;

          final loginEntity = LoginWrapperEntity(
            clientEntity: client,
            userEntity: userEntity,
            loginEntity: LoginEntity.fromJson(response.data),
          );

          print('login entity = $loginEntity');

          return LoginWrapperEntity(
            clientEntity: client,
            userEntity: userEntity,
            loginEntity: LoginEntity.fromJson(response.data),
          );
        }
      }
    }
    return null;
  }

  @override
  Future<LoginWrapperEntity?> register({
    required String username,
    required String email,
    required String password,
    DateTime? birthDay,
  }) async {
    // Create token

    // Register
    final response = await _dio.post(
      '/users',
      data: {
        'email': email,
        'username': username,
        'password': password,
        'birthday': birthDay?.toIso8601String(),
      },
    );

    print(response.statusCode);

    print(response.statusMessage);

    if (response.statusCode == 201) {
      final tokenResponse = await _dio.post(
        '/clients',
        data: {
          'name': email,
          "allowedGrantTypes": [
            "password",
            "refresh_token",
          ]
        },
      );

      if (tokenResponse.statusCode == 201) {
        return await authenticateWithUsernameAndPassword(
          username: username,
          password: password,
        );
      }
    }
    return null;
  }
}
