import '../domain.dart';

abstract class UserRepository {
  Future<UserEntity?> getCurrentUser();

  Future<UserEntity?> getUserById({required String userId});

  Future<UserEntity?> updateUserPassword({
    required oldPassword,
    required password,
    required String userId,
  });

  Future<UserEntity?> updateUser({required UserEntity userEntity});
}
