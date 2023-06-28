import 'package:domain/domain.dart';

abstract class MediaRepository {
  Future<PaginatedWrapperEntity<MediaEntity>?> getMedia({
    int limit = 10,
    int page,
    bool popular = false,
    bool newMedia = false,
    By by = By.defaultQuery,
  });

  Future<PaginatedWrapperEntity<MediaEntity>?> getMediaByUserId({
    int limit = 10,
    int page,
    required int userId,
  });

  Future<MediaEntity?> uploadImage({
    required String title,
    required String description,
    required String filePath,
  });
}
