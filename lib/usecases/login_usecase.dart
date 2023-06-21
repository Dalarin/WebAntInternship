import 'package:domain/domain.dart';

class LoginUseCase {
  final AuthenticateRepository _repository;
  final SharedPreferencesRepository _securedStorage;

  LoginUseCase({
    required AuthenticateRepository repository,
    required SharedPreferencesRepository securedStorage,
  })  : _repository = repository,
        _securedStorage = securedStorage;

  Future<bool> authenticate({
    required String username,
    required String password,
  }) async {
    final response = await _repository.authenticateWithUsernameAndPassword(
      username: username,
      password: password,
    );

    if (response != null) {
      _securedStorage.saveLoginEntity(entity: response);

      return true;
    }

    return false;
  }
}
