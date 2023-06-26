part of 'media_info_bloc.dart';

@freezed
class MediaInfoState with _$MediaInfoState {
  const factory MediaInfoState({
    @Default(Status.initial) Status status,
    MediaInfo? mediaInfo,
  }) = _MediaInfoState;
}
