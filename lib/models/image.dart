import 'package:domain/entities/image_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';

@freezed
class Image with _$Image {
  const factory Image({
    int? id,
    String? name,
  }) = _Image;

  factory Image.fromEntity(ImageEntity entity) {
    return Image(id: entity.id, name: entity.name);
  }
}
