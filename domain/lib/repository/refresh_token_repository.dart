import 'package:domain/domain.dart';

abstract class RefreshTokenRepository {
  Future<LoginEntity?> refreshToken({required LoginWrapperEntity entity});
}
