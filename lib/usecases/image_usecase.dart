import 'package:domain/domain.dart';
import 'package:webant_internship/models/media.dart';
import 'package:webant_internship/models/media_info.dart';

class ImageUseCase {
  final MediaRepository _repository;
  final FirebaseRepository _firebaseRepository;
  final SharedPreferencesRepository _sharedPreferencesRepository;

  ImageUseCase({
    required MediaRepository repository,
    required FirebaseRepository firebaseRepository,
    required SharedPreferencesRepository sharedPreferencesRepository,
  })  : _repository = repository,
        _firebaseRepository = firebaseRepository,
        _sharedPreferencesRepository = sharedPreferencesRepository;

  Future<MediaInfo?> getMediaInfo({
    required String mediaId,
  }) async {
    final mediaInfo = await _firebaseRepository.getMediaInfo(mediaId: mediaId);

    if (mediaInfo != null) {
      return MediaInfo.fromEntity(mediaInfo);
    }
    return null;
  }

  Future<MediaInfo> updateMediaInfo({
    required MediaInfo mediaInfo,
  }) async {
    final media = await _firebaseRepository.updateMediaInfo(
      entity: mediaInfo.toEntity(),
    );

    return MediaInfo.fromEntity(media!);
  }

  Future<Media?> uploadImage({
    required String title,
    required String description,
    required String filePath,
  }) async {
    final mediaEntity = await _repository.uploadImage(
      title: title,
      description: description,
      filePath: filePath,
    );

    if (mediaEntity != null) {
      return Media.fromEntity(mediaEntity);
    }

    return null;
  }

  Future<List<Media>?> getImagesForCurrentUser({
    int page = 0,
  }) async {
    final currentUser = await _sharedPreferencesRepository.getLoginEntity();

    final mediaWrapper = await _repository.getMediaByUserId(
      userId: currentUser!.userEntity.id,
      page: page,
    );

    if (mediaWrapper != null) {
      return mediaWrapper.data.map<Media>(
        (media) {
          return Media.fromEntity(media);
        },
      ).toList();
    }

    return null;
  }

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
