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

  const factory ImageEvent.getImagesForCurrentUser({
    @Default(true) bool isNewRequest,
  }) = _GetImagesForCurrentUser;

  const factory ImageEvent.uploadImage({
    required String title,
    required String description,
    required File file,
  }) = _UploadImage;
}
