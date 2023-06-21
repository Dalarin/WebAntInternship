import 'package:freezed_annotation/freezed_annotation.dart';

import '../helpers/enums.dart';

part 'user_entity.g.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required int id,
    required int email,
    required bool enabled,
    required String username,
    String? phone,
    String? fullName,
    @JsonKey(name: 'birthday') DateTime? birthDay,
    @Default([]) List<Role> roles,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
