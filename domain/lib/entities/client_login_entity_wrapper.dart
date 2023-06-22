import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_login_entity_wrapper.g.dart';

part 'client_login_entity_wrapper.freezed.dart';

@freezed
class LoginWrapperEntity with _$LoginWrapperEntity {
  const factory LoginWrapperEntity({
    required ClientEntity clientEntity,
    required LoginEntity loginEntity,
    required UserEntity userEntity,
  }) = _LoginWrapperEntity;

  factory LoginWrapperEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginWrapperEntityFromJson(json);
}
