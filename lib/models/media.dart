import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webant_internship/models/image.dart';

part 'media.freezed.dart';

@freezed
class Media with _$Media {
  const factory Media({
    required int id,
    required String name,
    required String description,
    DateTime? creationDate,
    Image? image,
    required bool newMedia,
    required bool popular,
    String? user,
  }) = _Media;

  const Media._();


  factory Media.fromEntity(MediaEntity entity) {
    return Media(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      newMedia: entity.newMedia,
      popular: entity.popular,
      user: entity.user,
      creationDate: entity.creationDate,
      image: Image.fromEntity(entity.image),
    );
  }
}
