import 'package:json_annotation/json_annotation.dart';
import 'package:webant_internship/models/image.dart';

part 'generated/media.g.dart';

@JsonSerializable()
class Media {
  final int id;
  final String name;
  @JsonKey(name: 'dateCreate')
  final DateTime creationDate;
  final String description;
  @JsonKey(name: 'new')
  final bool newMedia;
  final bool popular;
  @JsonKey(name: 'image')
  final ImageModel? image;
  final String? user;

  const Media({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.description,
    required this.newMedia,
    required this.popular,
    this.image,
    this.user,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
