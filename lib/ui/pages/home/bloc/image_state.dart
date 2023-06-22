part of 'image_bloc.dart';

@freezed
class ImageState with _$ImageState {
  const factory ImageState({
    @Default(Status.initial) Status status,
    @Default([]) List<Media> media,
    @Default(false) bool hasReachedMax,
    @Default(ErrorEnum.internal) ErrorEnum errorEnum,
    @Default('Произошла непредвиденная ошибка') String error,
  }) = _ImageState;
}
