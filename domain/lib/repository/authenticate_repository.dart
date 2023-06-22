

import '../entities/client_login_entity_wrapper.dart';

abstract class AuthenticateRepository {
  Future<LoginWrapperEntity?> authenticateWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<LoginWrapperEntity?> register({
    required String username,
    required String email,
    required String password,
    DateTime? birthDay,
  });
}
