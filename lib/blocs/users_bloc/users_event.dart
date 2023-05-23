part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUserById extends UsersEvent {
  final String userId;

  const GetUserById(this.userId);
}