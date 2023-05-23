import 'package:webant_internship/blocs/image_bloc/request/image_service.dart';
import 'package:webant_internship/models/media.dart';

class ImageRepository {
  final _service = ImageService();

  Future<List<Media>?> getImages(bool popular, bool newMedia, int page) async {
    final response = await _service.getImages(page, popular, newMedia);
    final data = response['data'] as List;
    return data.map<Media>(
      (media) {
        return Media.fromJson(media);
      },
    ).toList();
  }
}
