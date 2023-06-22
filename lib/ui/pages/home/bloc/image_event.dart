part of 'image_bloc.dart';

@freezed
class ImageEvent with _$ImageEvent {
  const factory ImageEvent.getImages({
    @Default(true) bool isNewMedia,
    @Default(false) bool isPopular,
    @Default(false) bool isSearching,
    @Default(true) bool isNewRequest,
    @Default('') String query,
  }) = _GetImages;
}
