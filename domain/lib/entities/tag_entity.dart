import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_entity.g.dart';

part 'tag_entity.freezed.dart';

@freezed
class TagEntity with _$TagEntity {
  const factory TagEntity({
    @JsonKey(name: 'media_id') required String mediaId,
    required List<String> tags,
  }) = _TagEntity;

  factory TagEntity.fromJson(Map<String, dynamic> json) => _$TagEntityFromJson(json);
}
