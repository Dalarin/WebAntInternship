import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_entity.g.dart';

part 'client_entity.freezed.dart';

@freezed
class ClientEntity with _$ClientEntity {
  const factory ClientEntity({
    required int id,
    required String name,
    required String randomId,
    required String secret,
    required List<String> allowedGrantTypes,
  }) = _ClientEntity;

  factory ClientEntity.fromJson(Map<String, dynamic> json) => _$ClientEntityFromJson(json);
}
