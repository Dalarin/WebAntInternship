
import 'package:domain/entities/paginated_entity_wrapper.dart';

import '../entities/media_entity.dart';

abstract class MediaRepository {
  Future<PaginatedWrapperEntity<MediaEntity>?> getMedia({
    int limit = 10,
    int page,
    bool popular = false,
    bool newMedia = false,
  });
}
