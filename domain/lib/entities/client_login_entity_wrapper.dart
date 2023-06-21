import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_login_entity_wrapper.g.dart';

part 'client_login_entity_wrapper.freezed.dart';

@freezed
class ClientLoginEntity with _$ClientLoginEntity {
  const factory ClientLoginEntity({
    required ClientEntity clientEntity,
    required LoginEntity loginEntity,
  }) = _ClientLoginEntity;

  factory ClientLoginEntity.fromJson(Map<String, dynamic> json) =>
      _$ClientLoginEntityFromJson(json);
}
