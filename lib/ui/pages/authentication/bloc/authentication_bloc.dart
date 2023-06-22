import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webant_internship/usecases/login_usecase.dart';

import '../../../../resources/resources.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

part 'authentication_bloc.freezed.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase _loginUseCase;

  AuthenticationBloc({
    required LoginUseCase loginUseCase,
  })  : _loginUseCase = loginUseCase,
        super(const AuthenticationState()) {
    on<_Authenticate>(_onAuthenticate);
    on<_Register>(_onRegister);
    on<_Started>(_onApplicationStarted);
  }

  FutureOr<void> _onAuthenticate(
    _Authenticate event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await _loginUseCase.authenticate(
      username: event.email,
      password: event.password,
    );

    if (response != null) {
      return emit(state.copyWith(status: Status.success));
    }

    return emit(state.copyWith(status: Status.failure));
  }

  FutureOr<void> _onRegister(
    _Register event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await _loginUseCase.register(
      username: event.username,
      email: event.email,
      password: event.password,
      birthDate: event.birthDate,
    );

    if (response != null) {
      return emit(
        state.copyWith(status: Status.success),
      );
    }

    return emit(
      state.copyWith(status: Status.success),
    );
  }

  FutureOr<void> _onApplicationStarted(
    _Started event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final response = await _loginUseCase.verifyAuthentication();

    if (response != null) {
      return emit(
        state.copyWith(
          status: Status.success,
        ),
      );
    }

    return emit(
      state.copyWith(status: Status.initial),
    );
  }
}
