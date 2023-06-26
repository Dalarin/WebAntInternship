import 'package:domain/entities/image_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_entity.g.dart';

part 'media_entity.freezed.dart';

@freezed
class MediaEntity with _$MediaEntity {
  const factory MediaEntity({
    required final int id,
    @Default("") final String name,
    @Default("") final String description,
    required final ImageEntity image,
    @Default(false) final bool popular,
    @JsonKey(name: 'new') @Default(false) final bool newMedia,
    @JsonKey(name: 'dateCreate') DateTime? creationDate,
    final String? user,
  }) = _MediaEntity;

  factory MediaEntity.fromJson(Map<String, dynamic> json) => _$MediaEntityFromJson(json);
}
