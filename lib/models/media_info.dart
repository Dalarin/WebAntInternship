import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_info.freezed.dart';

@freezed
class MediaInfo with _$MediaInfo {
  const factory MediaInfo({
    @JsonKey(name: 'media_id') required String mediaId,
    required List<String> likes,
    required List<String> tags,
  }) = _MediaInfo;

  factory MediaInfo.fromEntity(MediaInfoEntity entity) {
    return MediaInfo(
      mediaId: entity.mediaId,
      likes: entity.likes,
      tags: entity.tags,
    );
  }

  const MediaInfo._();

  MediaInfoEntity toEntity() {
    return MediaInfoEntity(
      mediaId: mediaId,
      tags: tags,
      likes: likes,
    );
  }
}
