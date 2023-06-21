import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.dart';

part 'splash_state.dart';

part 'splash_bloc.freezed.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SharedPreferencesRepository _secureStorage;

  SplashBloc({
    required SharedPreferencesRepository storage,
  })  : _secureStorage = storage,
        super(const SplashState()) {
    on<SplashEvent>(
      (event, emit) async {


        emit(state.copyWith(status: SplashStatus.loading));

        final response = await _secureStorage.getLoginEntity();

        if (response != null) {
          return emit(
            state.copyWith(status: SplashStatus.authorized),
          );
        }

        return emit(
          state.copyWith(status: SplashStatus.unauthorized),
        );
      },
    );
  }
}
