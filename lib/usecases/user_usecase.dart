import 'package:domain/domain.dart';

import '../models/user.dart';

class UserUseCase {
  final UserRepository _userRepository;

  UserUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<User?> getCurrentUser() async {
    final userEntity = await _userRepository.getCurrentUser();

    if (userEntity != null) {
      return User.fromEntity(userEntity);
    }
    return null;
  }

  Future<User?> getUserById({required String userId}) async {
    final userEntity = await _userRepository.getUserById(userId: userId);

    if (userEntity != null) {
      return User.fromEntity(userEntity);
    }

    return null;
  }

  Future<User?> updateUser({required User user}) async {
    final userEntity = await _userRepository.updateUser(userEntity: user.toEntity());

    if (userEntity != null) {
      return User.fromEntity(userEntity);
    }

    return null;
  }

  Future<User?> changeUserPassword({
    required String oldPassword,
    required String password,
    required String userId,
  }) async {
    final userEntity = await _userRepository.updateUserPassword(
      oldPassword: oldPassword,
      password: password,
      userId: userId,
    );

    if (userEntity != null) {
      return User.fromEntity(userEntity);
    }

    return null;
  }
}
