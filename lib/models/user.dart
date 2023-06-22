import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String email,
    required String userName,
    String? phone,
    DateTime? birthDate,
  }) = _User;

  factory User.fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      email: entity.email,
      userName: entity.username,
      phone: entity.phone,
      birthDate: entity.birthDay,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
