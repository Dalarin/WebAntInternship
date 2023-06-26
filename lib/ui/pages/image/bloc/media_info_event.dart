part of 'media_info_bloc.dart';

@freezed
class MediaInfoEvent with _$MediaInfoEvent {
  const factory MediaInfoEvent.getMediaInfo({
    required String mediaId,
  }) = _GetMediaInfo;

  const factory MediaInfoEvent.changeLike({
    required String userId,
  }) = _ChangeLike;

  const factory MediaInfoEvent.createMediaInfo({
    required List<String> tags,
    required String mediaId,
  }) = _CreateMediaInfo;
}
