part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.started() = _Started;

  const factory AuthenticationEvent.authenticate({
    required String email,
    required String password,
  }) = _Authenticate;

  const factory AuthenticationEvent.register({
    required String username,
    required String email,
    required String password,
    DateTime? birthDate,
  }) = _Register;
}
