import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_entity.g.dart';

part 'media_entity.freezed.dart';

@freezed
class MediaEntity with _$MediaEntity {
  const factory MediaEntity({
    required final int id,
    @Default("") final String name,
    @Default("") final String description,
    required final bool popular,
    @JsonKey(name: 'new') required final bool newMedia,
    required final Map<String, dynamic> image,
    final String? user,
  }) = _MediaEntity;

  factory MediaEntity.fromJson(Map<String, dynamic> json) => _$MediaEntityFromJson(json);
}
