import 'dart:async';

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
  final S _appLocalization;

  ImageBloc({
    required ImageUseCase imagesUseCase,
    required S localization,
  })  : _imageUseCase = imagesUseCase,
        _appLocalization = localization,
        super(const ImageState()) {
    on<_GetImages>(_onGetImages);
  }

  FutureOr<void> _onGetImages(
    _GetImages event,
    Emitter<ImageState> emit,
  ) async {
    try {
      if (state.hasReachedMax && !event.isSearching) {
        return;
      }
      emit(state.copyWith(status: Status.loading));

      int page = event.isNewRequest ? 1 : (state.media.length ~/ 10) + 1;

      page = event.isSearching ? 1 : page;

      final response = await _imageUseCase.getImages(
        newMedia: event.isNewMedia,
        popular: event.isPopular,
        page: page,
      );

      if (response != null) {
        return emit(
          state.copyWith(
            media: response,
            status: Status.success,
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
}
