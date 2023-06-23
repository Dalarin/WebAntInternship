part of 'camera_bloc.dart';

@freezed
class CameraEvent with _$CameraEvent {
  const factory CameraEvent.takePicture() = _TakePicture;

  const factory CameraEvent.pickImages({required File file}) = _PickImages;
}
