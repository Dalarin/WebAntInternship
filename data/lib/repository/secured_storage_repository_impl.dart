import 'dart:convert';

import 'package:domain/domain.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorageRepositoryImpl implements SharedPreferencesRepository {
  final FlutterSecureStorage _secureStorage;

  SecuredStorageRepositoryImpl(FlutterSecureStorage secureStorage) : _secureStorage = secureStorage;

  @override
  Future<LoginWrapperEntity?> getLoginEntity() async {
    final response = await _secureStorage.read(key: 'login_data');

    if (response != null) {
      return LoginWrapperEntity.fromJson(jsonDecode(response));
    }

    return null;
  }

  @override
  void saveLoginEntity({required LoginWrapperEntity entity}) async {
    await _secureStorage.write(
      key: 'login_data',
      value: jsonEncode(entity.toJson()),
    );
  }
}
