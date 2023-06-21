part of 'splash_bloc.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(SplashStatus.loading) final SplashStatus status,
  }) = _SplashState;
}

enum SplashStatus { loading, authorized, unauthorized }
