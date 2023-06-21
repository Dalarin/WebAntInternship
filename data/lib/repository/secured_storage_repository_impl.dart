import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:domain/entities/login_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorageRepositoryImpl implements SharedPreferencesRepository {
  final FlutterSecureStorage _secureStorage;

  SecuredStorageRepositoryImpl(FlutterSecureStorage secureStorage) : _secureStorage = secureStorage;

  @override
  Future<LoginEntity?> getLoginEntity() async {
    final response = await _secureStorage.read(key: 'login_data');

    if (response != null) {
      return LoginEntity.fromJson(jsonDecode(response));
    }

    return null;
  }

  @override
  void saveLoginEntity({required LoginEntity entity}) async {
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

  @override
  Future<ClientEntity?> getClientEntity() async {
    final response = await _secureStorage.read(key: 'client_data');

    if (response != null) {
      return ClientEntity.fromJson(jsonDecode(response));
    }

    return null;
  }

  @override
  void saveUserClient({required ClientEntity entity}) async {
    await _secureStorage.write(
      key: 'client_data',
      value: jsonEncode(entity.toJson()),
    );
  }
}
