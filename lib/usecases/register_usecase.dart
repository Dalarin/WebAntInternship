import 'package:domain/domain.dart';

import '../models/user.dart';

class RegisterUseCase {
  final AuthenticateRepository _repository;
  final SharedPreferencesRepository _securedStorage;

  RegisterUseCase({
    required AuthenticateRepository repository,
    required SharedPreferencesRepository securedStorage,
  })  : _repository = repository,
        _securedStorage = securedStorage;

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
      _securedStorage.saveUserEntity(entity: response);

      return User.fromEntity(response);
    }

    return null;
  }
}
