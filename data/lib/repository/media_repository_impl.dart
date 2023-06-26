import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

class MediaRepositoryImpl implements MediaRepository {
  final Dio _dio;

  MediaRepositoryImpl(Dio dio) : _dio = dio;

  @override
  Future<PaginatedWrapperEntity<MediaEntity>?> getMedia({
    int limit = 10,
    int page = 0,
    bool popular = false,
    bool newMedia = false,
  }) async {
    final response = await _dio.get(
      '/photos',
      queryParameters: {
        'limit': limit,
        'page': page,
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

  @override
  Future<MediaEntity?> uploadImage({
    required String title,
    required String description,
    required String filePath,
  }) async {
    final imageName = filePath.split('/').last;

    final media = await _dio.post(
      '/media_objects',
      data: FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(
            filePath,
            filename: imageName,
          ),
        },
      ),
    );

    if (media.statusCode == 201) {
      final photoObjectResponse = await _dio.post(
        '/photos',
        data: {
          'name': title,
          'description': description,
          'new': true,
          'popular': false,
          'image': '/api/media_objects/${media.data['id']}',
          'dateCreate': DateTime.now().toIso8601String(),
        },
      );

      if (photoObjectResponse.statusCode == 201) {
        return MediaEntity.fromJson(photoObjectResponse.data);
      }
    }
    return null;
  }

  @override
  Future<PaginatedWrapperEntity<MediaEntity>?> getMediaByUserId({
    int limit = 10,
    int page = 1,
    required int userId,
  }) async {
    final mediaResponse = await _dio.get(
      '/photos',
      queryParameters: {
        'limit': limit,
        'page': page,
        'user.id': userId,
      },
    );

    if (mediaResponse.statusCode == 200) {
      final data = mediaResponse.data;

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
