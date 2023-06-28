import 'package:freezed_annotation/freezed_annotation.dart';

enum Role {
  @JsonValue('ROLE_USER')
  user
}

enum By {
  @JsonValue('user.id')
  user,
  @JsonValue('name')
  query,
  defaultQuery,
}

extension ByEnum on By {
  String get value {
    switch (this) {
      case By.user:
        return 'user.id';
      case By.query:
        return 'name';
      case By.defaultQuery:
        return 'default';
    }
  }
}
