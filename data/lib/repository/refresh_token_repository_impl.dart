import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class RefreshTokenRepositoryImpl implements RefreshTokenRepository {
  @override
  Future<LoginEntity?> refreshToken({required LoginWrapperEntity entity}) async {
    final client = entity.clientEntity;

    final response = await Dio().get(
      'https://gallery.prod1.webant.ru/oauth/v2/token',
      queryParameters: {
        'client_id': '${client.id}_${client.randomId}',
        'grant_type': 'refresh_token',
        'username': entity.userEntity.username,
      },
    );

    if (response.statusCode == 200) {
      return LoginEntity.fromJson(response.data);
    }
    return null;
  }
}
