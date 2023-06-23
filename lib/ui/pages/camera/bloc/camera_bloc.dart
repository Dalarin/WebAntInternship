import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webant_internship/helpers/camera_helper.dart';
import 'package:webant_internship/helpers/permission_helper.dart';

import '../../../../resources/resources.dart';

part 'camera_event.dart';

part 'camera_state.dart';

part 'camera_bloc.freezed.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(const CameraState()) {
    on<_TakePicture>(_onTakePicture);
    on<_PickImages>(_onPickImages);
  }

  FutureOr<void> _onTakePicture(
    _TakePicture event,
    Emitter<CameraState> emit,
  ) async {
    try {
      if (await PermissionHelper.requestPermissions()) {
        emit(state.copyWith(status: Status.loading));

        final picture = await CameraHelper.takePictures();

        final temporaryDirectory = await getTemporaryDirectory();

        final pictureFile = File('${temporaryDirectory.path}/${picture.name}');

        pictureFile.writeAsBytesSync(await picture.readAsBytes());

        return emit(
          state.copyWith(
            status: Status.success,
            selectedPicture: pictureFile,
          ),
        );
      }
    } catch (exception) {
      return emit(
        state.copyWith(status: Status.failure),
      );
    }
  }

  FutureOr<void> _onPickImages(
    _PickImages event,
    Emitter<CameraState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    return emit(
      state.copyWith(
        status: Status.success,
        selectedPicture: event.file,
      ),
    );
  }
}
