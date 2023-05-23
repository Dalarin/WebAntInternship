part of 'users_bloc.dart';

class UsersState extends Equatable {
  final Status status;
  final List<User> user;

  const UsersState({
    this.status = Status.initial,
    this.user = const <User>[],
  });

  UsersState copyWith({
    Status? status,
    List<User>? user,
  }) {
    return UsersState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status, user];
}
