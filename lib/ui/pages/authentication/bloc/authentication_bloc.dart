import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webant_internship/usecases/login_usecase.dart';

import '../../../../resources/resources.dart';
import '../../../../usecases/register_usecase.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

part 'authentication_bloc.freezed.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthenticationBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        super(const AuthenticationState()) {
    on<_Authenticate>(_onAuthenticate);
    on<_Register>(_onRegister);
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

    if (response == true) {
      return emit(state.copyWith(status: Status.success));
    }

    return emit(state.copyWith(status: Status.failure));
  }

  FutureOr<void> _onRegister(
    _Register event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await _registerUseCase.register(
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
}
