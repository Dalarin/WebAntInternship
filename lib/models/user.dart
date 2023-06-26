import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

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

  const User._();

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      enabled: true,
      username: userName,
    );
  }
}
