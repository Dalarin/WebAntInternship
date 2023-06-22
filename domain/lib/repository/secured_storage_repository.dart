import 'package:domain/domain.dart';

abstract class SharedPreferencesRepository {
  void saveLoginEntity({required LoginWrapperEntity entity});

  Future<LoginWrapperEntity?> getLoginEntity();
}
