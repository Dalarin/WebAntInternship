import 'package:json_annotation/json_annotation.dart';

part 'generated/user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String? email;
  final String? phone;
  final String? fullName;
  final String? userName;
  @JsonKey(name: 'birthday')
  final DateTime? birthDate;

  const User({
    required this.id,
    this.email,
    this.phone,
    this.fullName,
    this.userName,
    required this.birthDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}