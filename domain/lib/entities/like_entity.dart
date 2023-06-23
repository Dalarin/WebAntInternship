import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_entity.g.dart';

part 'like_entity.freezed.dart';

@freezed
class LikeEntity with _$LikeEntity {
  const factory LikeEntity({
    @JsonKey(name: 'media_id') required String mediaId,
    @JsonKey(name: 'likes') required List<String> users,
  }) = _LikeEntity;

  factory LikeEntity.fromJson(Map<String, dynamic> json) => _$LikeEntityFromJson(json);
}
