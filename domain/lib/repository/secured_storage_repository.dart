import 'package:domain/domain.dart';
import 'package:domain/entities/client_login_entity_wrapper.dart';

abstract class SharedPreferencesRepository {
  void saveLoginEntity({required ClientLoginEntity entity});

  void saveUserEntity({required RegisterUserEntity entity});

  Future<RegisterUserEntity?> getUserEntity();

  Future<ClientLoginEntity?> getLoginEntity();
}
