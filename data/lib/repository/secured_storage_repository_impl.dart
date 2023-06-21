import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorageRepositoryImpl implements SharedPreferencesRepository {
  final FlutterSecureStorage _secureStorage;

  SecuredStorageRepositoryImpl(FlutterSecureStorage secureStorage) : _secureStorage = secureStorage;

  @override
  Future<ClientLoginEntity?> getLoginEntity() async {
    final response = await _secureStorage.read(key: 'login_data');

    if (response != null) {
      return ClientLoginEntity.fromJson(jsonDecode(response));
    }

    return null;
  }

  @override
  void saveLoginEntity({required ClientLoginEntity entity}) async {
    await _secureStorage.write(
      key: 'login_data',
      value: jsonEncode(entity.toJson()),
    );
  }

  @override
  Future<RegisterUserEntity?> getUserEntity() async {
    final response = await _secureStorage.read(key: 'user_data');

    if (response != null) {
      return RegisterUserEntity.fromJson(jsonDecode(response));
    }
    return null;
  }

  @override
  void saveUserEntity({required RegisterUserEntity entity}) async {
    await _secureStorage.write(
      key: 'login_data',
      value: jsonEncode(entity.toJson()),
    );
  }
}
