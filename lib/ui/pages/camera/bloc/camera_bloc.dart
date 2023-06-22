import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webant_internship/resources/app_enums.dart';

part 'camera_event.dart';

part 'camera_state.dart';

part 'camera_bloc.freezed.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(const CameraState()) {
    on<_Initialize>(_onInitialize);
  }

  FutureOr<void> _onInitialize(
    _Initialize event,
    Emitter<CameraState> emit,
  ) async {
    try {
      final cameras = await availableCameras();

      final controller = CameraController(cameras.first, ResolutionPreset.ultraHigh);

      await controller.initialize();

      return emit(
        state.copyWith(status: Status.success, controller: controller),
      );
    } on CameraException catch (exception) {
      return emit(
        state.copyWith(status: Status.failure),
      );

    }
  }
}
