import 'package:domain/entities/client_login_entity_wrapper.dart';
import 'package:domain/entities/login_entity.dart';

import '../entities/register_user_entity.dart';

abstract class AuthenticateRepository {
  Future<ClientLoginEntity?> authenticateWithUsernameAndPassword({
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
