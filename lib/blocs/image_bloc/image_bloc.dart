import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/blocs/image_bloc/repository/image_repository.dart';
import 'package:webant_internship/models/media.dart';
import 'package:webant_internship/utils/enums.dart';

part 'image_event.dart';

part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final _repository = ImageRepository();

  ImageBloc() : super(const ImageState()) {
    on<GetImages>(_onGetImages);
    on<UploadImage>(_onUploadImage);
  }

  FutureOr<void> _onGetImages(GetImages event, Emitter<ImageState> emit) async {
    try {
      if (state.hasReachedEnd) return;

      emit(state.copyWith(status: Status.loading));

      final nextPage = event.newRequest ? 1 : (state.media.length ~/ 10) + 1;
      final images = await _repository.getImages(event.popular, event.newMedia, nextPage);

      if (images != null) {
        if (images.isEmpty) {
          emit(state.copyWith(hasReachedEnd: true, media: state.media));
        }

        final media = event.newRequest ? [...images] : [...state.media, ...images];

        emit(state.copyWith(media: media, status: Status.success));
      }
    } on SocketException {
      emit(state.copyWith(status: Status.failure, errorEnum: ErrorEnum.connection));
    } catch (exception) {
      emit(state.copyWith(status: Status.failure, errorEnum: ErrorEnum.all));
    }
  }

  FutureOr<void> _onUploadImage(
    UploadImage event,
    Emitter<ImageState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
    } on Exception catch (exception) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
