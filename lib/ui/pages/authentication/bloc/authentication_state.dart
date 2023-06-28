part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(Status.initial) final Status status,
    @Default(ErrorEnum.unknown) final ErrorEnum errorEnum,
    @Default({}) final Map<Fields, FieldsError>? fields,
  }) = _AuthenticateState;
}
