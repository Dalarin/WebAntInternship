

import 'package:json_annotation/json_annotation.dart';


part 'generated/image.g.dart';

@JsonSerializable()
class ImageModel {
  final int id;
  final String name;

  const ImageModel({
    required this.id,
    required this.name,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}