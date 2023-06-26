import 'dart:async';
import 'dart:io';

import 'package:data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/app_enums.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/media.dart';
import '../../../../usecases/image_usecase.dart';

part 'image_event.dart';

part 'image_state.dart';

part 'image_bloc.freezed.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageUseCase _imageUseCase;

  ImageBloc({
    required ImageUseCase imagesUseCase,
  })  : _imageUseCase = imagesUseCase,
        super(const ImageState()) {
    on<_GetImages>(_onGetImages);
    on<_UploadImage>(_onUploadImage);
    on<_GetImagesForCurrentUser>(_onGetImagesByUserId);
  }

  FutureOr<void> _onGetImages(
    _GetImages event,
    Emitter<ImageState> emit,
  ) async {
    try {
      if (state.hasReachedMax && !event.isSearching && !event.isNewRequest) {
        return;
      }
      emit(state.copyWith(status: Status.loading));

      int page = event.isNewRequest ? 1 : (state.media.length ~/ 10) + 1;

      page = event.isSearching ? 1 : page;

      ;
      final response = await _imageUseCase.getImages(
        newMedia: event.isNewMedia,
        popular: event.isPopular,
        page: page,
      );

      if (response != null) {
        final images = event.isNewRequest ? response : [...state.media, ...response];

        return emit(
          state.copyWith(
            media: images,
            status: Status.success,
            hasReachedMax: response.isEmpty,
          ),
        );
      }

      return emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    } on BaseException catch (exception) {
      return emit(
        state.copyWith(
          status: Status.failure,
          errorEnum: exception.errorEnum,
        ),
      );
    }
  }

  FutureOr<void> _onGetImagesByUserId(
    _GetImagesForCurrentUser event,
    Emitter<ImageState> emit,
  ) async {
    try {
      if (state.hasReachedMax) return;

      int page = (state.media.length ~/ 10) + 1;

      final response = await _imageUseCase.getImagesForCurrentUser(
        page: page,
      );

      if (response != null) {
        final images = event.isNewRequest ? response : [...state.media, ...response];

        return emit(
          state.copyWith(
            media: images,
            status: Status.success,
            hasReachedMax: response.isEmpty,
          ),
        );
      }

      return emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    } on BaseException catch (exception) {
      return emit(
        state.copyWith(
          status: Status.failure,
          errorEnum: exception.errorEnum,
        ),
      );
    }
  }

  FutureOr<void> _onUploadImage(
    _UploadImage event,
    Emitter<ImageState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final image = await _imageUseCase.uploadImage(
      title: event.title,
      filePath: event.file.path,
      description: event.description,
    );

    if (image != null) {
      return emit(
        state.copyWith(
          status: Status.success,
          media: [image, ...state.media],
        ),
      );
    }

    return emit(
      state.copyWith(
        status: Status.failure,
      ),
    );
  }
}
