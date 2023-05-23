import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/blocs/users_bloc/repository/user_repository.dart';
import 'package:webant_internship/models/user.dart';
import 'package:webant_internship/utils/enums.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _repository = UserRepository();

  UsersBloc() : super(const UsersState()) {
    on<GetUserById>(_onGetUserById);
  }

  FutureOr<void> _onGetUserById(
    GetUserById event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final userId = event.userId.split('/').last;
    final user = await _repository.getUserById(userId);
    if (user != null) {
      emit(state.copyWith(status: Status.success, user: [user]));
    } else {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
