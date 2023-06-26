import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webant_internship/resources/resources.dart';

import '../../../../models/user.dart';
import '../../../../usecases/user_usecase.dart';

part 'user_event.dart';

part 'user_state.dart';

part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase _useCase;

  UserBloc({required UserUseCase useCase})
      : _useCase = useCase,
        super(const UserState()) {
    on<_GetUserById>(_onGetUserById);
    on<_GetCurrentUser>(_onGetCurrentUser);
    on<_ChangePassword>(_onChangePassword);
    on<_UpdateUser>(_onUpdateUser);
  }

  FutureOr<void> _onGetUserById(
    _GetUserById event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    if (event.userId != null) {
      final userId = event.userId!.split('/').last;

      final user = await _useCase.getUserById(userId: userId);

      if (user != null) {
        return emit(
          state.copyWith(
            user: user,
            status: Status.success,
          ),
        );
      }
    }

    return emit(
      state.copyWith(
        status: Status.failure,
      ),
    );
  }

  FutureOr<void> _onGetCurrentUser(
    _GetCurrentUser event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final user = await _useCase.getCurrentUser();

    if (user != null) {
      return emit(
        state.copyWith(
          user: user,
          status: Status.success,
        ),
      );
    }

    return emit(
      state.copyWith(
        status: Status.failure,
      ),
    );
  }

  FutureOr<void> _onChangePassword(
    _ChangePassword event,
    Emitter<UserState> emit,
  ) {}

  FutureOr<void> _onUpdateUser(
    _UpdateUser event,
    Emitter<UserState> emit,
  ) {}
}
