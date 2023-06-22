part of 'camera_bloc.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState({
    @Default(Status.initial) Status status,
    CameraController? controller,
  }) = _CameraState;
}
