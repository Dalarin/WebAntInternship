import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_info_entity.g.dart';

part 'media_info_entity.freezed.dart';

@freezed
class MediaInfoEntity with _$MediaInfoEntity {
  const factory MediaInfoEntity({
    @JsonKey(name: 'media_id') required String mediaId,
    @JsonKey(name: 'tags') required List<String> tags,
    @JsonKey(name: 'likes') required List<String> likes,
  }) = _MediaInfoEntity;

  factory MediaInfoEntity.fromJson(Map<String, dynamic> json) => _$MediaInfoEntityFromJson(json);
}
