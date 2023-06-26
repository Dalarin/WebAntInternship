import 'package:domain/domain.dart';

abstract class SharedPreferencesRepository {
  Future<void> saveLoginEntity({required LoginWrapperEntity entity});

  Future<LoginWrapperEntity?> getLoginEntity();
}
