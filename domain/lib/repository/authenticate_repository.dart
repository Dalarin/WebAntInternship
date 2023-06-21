import 'package:domain/entities/login_entity.dart';

import '../entities/register_user_entity.dart';

abstract class AuthenticateRepository {
  Future<LoginEntity?> authenticateWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<RegisterUserEntity?> register({
    required String username,
    required String email,
    required String password,
    DateTime? birthDay,
  });
}
