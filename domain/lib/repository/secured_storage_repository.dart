import 'package:domain/domain.dart';
import 'package:domain/entities/login_entity.dart';

abstract class SharedPreferencesRepository {
  void saveLoginEntity({required LoginEntity entity});

  void saveUserEntity({required RegisterUserEntity entity});

  void saveUserClient({required ClientEntity entity});

  Future<RegisterUserEntity?> getUserEntity();

  Future<LoginEntity?> getLoginEntity();

  Future<ClientEntity?> getClientEntity();
}
