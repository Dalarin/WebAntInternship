part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.getUserById({required String? userId}) = _GetUserById;

  const factory UserEvent.changePassword({
    required String oldPassword,
    required String newPassword,
    required int userId,
  }) = _ChangePassword;

  const factory UserEvent.getCurrentUser() = _GetCurrentUser;

  const factory UserEvent.updateUser({
    required User user,
  }) = _UpdateUser;
}
