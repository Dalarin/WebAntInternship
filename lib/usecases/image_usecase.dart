import 'package:domain/domain.dart';
import 'package:webant_internship/models/media.dart';

class ImageUseCase {
  final MediaRepository _repository;

  ImageUseCase({required MediaRepository repository}) : _repository = repository;

  Future<List<Media>?> getImages({
    bool popular = false,
    bool newMedia = true,
    int page = 0,
  }) async {
    final response = await _repository.getMedia(
      page: page,
      popular: popular,
      newMedia: newMedia,
    );

    if (response != null) {
      final media = response.data.map<Media>(
        (media) {
          return Media.fromEntity(media);
        },
      ).toList();
      return media;
    }

    return null;
  }
}
