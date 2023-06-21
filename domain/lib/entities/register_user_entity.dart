import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_user_entity.g.dart';

part 'register_user_entity.freezed.dart';

@freezed
class RegisterUserEntity with _$RegisterUserEntity {
  const factory RegisterUserEntity({
    final String? phone,
    final String? fullName,
    final String? oldPassword,
    final String? newPassword,
    @JsonKey(name: 'birthday') final DateTime? birthDay,
    @Default([]) final List<String> photos,
    @Default(false) final bool user,
    final int? code,
    required final String username,
    required final List<String> roles,
    required final int id,
    required final String usernameCanonical,
    final String? salt,
    required final String email,
    required final String emailCanonical,
    required final String password,
    final String? plainPassword,
    final String? lastLogin,
    final String? confirmationToken,
    required final bool accountNonExpired,
    required final bool accountNonLocked,
    required final bool credentialsNonExpired,
    required final bool enabled,
    required final bool superAdmin,
  }) = _RegisterUserEntity;

  factory RegisterUserEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserEntityFromJson(json);
}
