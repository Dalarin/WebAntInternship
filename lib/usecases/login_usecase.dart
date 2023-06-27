import 'package:domain/domain.dart';

import '../models/user.dart';

class LoginUseCase {
  final AuthenticateRepository _repository;
  final SharedPreferencesRepository _securedStorage;

  LoginUseCase({
    required AuthenticateRepository repository,
    required SharedPreferencesRepository securedStorage,
  })  : _repository = repository,
        _securedStorage = securedStorage;

  Future<User?> authenticate({
    required String username,
    required String password,
  }) async {
    final response = await _repository.authenticateWithUsernameAndPassword(
      username: username,
      password: password,
    );

    if (response != null) {
      await _securedStorage.saveLoginEntity(entity: response);

      return User.fromEntity(response.userEntity);
    }

    return null;
  }

  Future<User?> register({
    required String username,
    required String email,
    required String password,
    DateTime? birthDate,
  }) async {
    final response = await _repository.register(
      username: username,
      email: email,
      password: password,
      birthDay: birthDate,
    );

    if (response != null) {
      await _securedStorage.saveLoginEntity(entity: response);

      return User.fromEntity(response.userEntity);
    }

    return null;
  }

  Future<User?> verifyAuthentication() async {
    final response = await _securedStorage.getLoginEntity();

    if (response != null) {
      return User.fromEntity(response.userEntity);
    }

    return null;
  }
}
