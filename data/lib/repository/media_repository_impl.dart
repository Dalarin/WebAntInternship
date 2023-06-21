import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class MediaRepositoryImpl implements MediaRepository {
  final Dio _dio;

  MediaRepositoryImpl(Dio dio) : _dio = dio;

  @override
  Future<PaginatedWrapperEntity<MediaEntity>?> getMedia({
    int limit = 10,
    bool popular = false,
    bool newMedia = false,
  }) async {
    final response = await _dio.get(
      '/photos',
      queryParameters: {
        'limit': limit,
        'popular': popular,
        'new': newMedia,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;

      return PaginatedWrapperEntity<MediaEntity>.fromJson(
        data,
        (Object? json) {
          return MediaEntity.fromJson(json as Map<String, dynamic>);
        },
      );
    }

    return null;
  }
}
