import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class UserRepositoryImpl implements UserRepository {
  final Dio _dio;
  final SharedPreferencesRepository _repository;

  UserRepositoryImpl({
    required Dio dio,
    required SharedPreferencesRepository repository,
  })  : _dio = dio,
        _repository = repository;

  @override
  Future<UserEntity?> getCurrentUser() async {
    final loginEntity = await _repository.getLoginEntity();

    if (loginEntity != null) {
      return loginEntity.userEntity;
    }
    return null;
  }

  @override
  Future<UserEntity?> getUserById({required String userId}) async {
    final userResponse = await _dio.get('/users/$userId');

    if (userResponse.statusCode == 200) {
      return UserEntity.fromJson(userResponse.data);
    }

    return null;
  }

  @override
  Future<UserEntity?> updateUser({required UserEntity userEntity}) async {
    final userResponse = await _dio.put(
      '/users/${userEntity.id}',
      data: userEntity.toJson(),
    );

    if (userResponse.statusCode == 200) {
      return UserEntity.fromJson(userResponse.data);
    }

    return null;
  }

  @override
  Future<UserEntity?> updateUserPassword({
    required oldPassword,
    required password,
    required String userId,
  }) async {
    final userResponse = await _dio.put(
      '/users/update_password/$userId',
      data: {
        'oldPassword': oldPassword,
        'newPassword': password,
      },
    );

    if (userResponse.statusCode == 200) {
      return UserEntity.fromJson(userResponse.data);
    }

    return null;
  }
}
