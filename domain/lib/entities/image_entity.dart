import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_entity.g.dart';

part 'image_entity.freezed.dart';

@freezed
class ImageEntity with _$ImageEntity {
  const factory ImageEntity({
    final int? id,
    final String? name,
  }) = _ImageEntity;

  factory ImageEntity.fromJson(Map<String, dynamic> json) => _$ImageEntityFromJson(json);
}
