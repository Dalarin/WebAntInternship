import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webant_internship/models/media_info.dart';

import '../../../../resources/resources.dart';
import '../../../../usecases/image_usecase.dart';

part 'media_info_event.dart';

part 'media_info_state.dart';

part 'media_info_bloc.freezed.dart';

class MediaInfoBloc extends Bloc<MediaInfoEvent, MediaInfoState> {
  final ImageUseCase _imageUseCase;

  MediaInfoBloc({required ImageUseCase imageUseCase})
      : _imageUseCase = imageUseCase,
        super(const MediaInfoState()) {
    on<_GetMediaInfo>(_onGetMediaInfo);
    on<_ChangeLike>(_onChangeLike);
    on<_CreateMediaInfo>(_onCreateMediaInfo);
  }

  FutureOr<void> _onGetMediaInfo(
    _GetMediaInfo event,
    Emitter<MediaInfoState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final mediaInfo = await _imageUseCase.getMediaInfo(mediaId: event.mediaId);

    if (mediaInfo != null) {
      return emit(
        state.copyWith(
          status: Status.success,
          mediaInfo: mediaInfo,
        ),
      );
    }

    return emit(
      state.copyWith(
        status: Status.failure,
      ),
    );
  }

  FutureOr<void> _onChangeLike(
    _ChangeLike event,
    Emitter<MediaInfoState> emit,
  ) async {
    final isAlreadyLiked = state.mediaInfo!.likes.contains(event.userId);

    final likes = List.of(state.mediaInfo!.likes);

    if (isAlreadyLiked) {
      likes.remove(event.userId);
    } else {
      likes.add(event.userId);
    }

    return emit(
      state.copyWith(
        status: Status.success,
        mediaInfo: await _imageUseCase.updateMediaInfo(
          mediaInfo: state.mediaInfo!.copyWith(
            likes: likes,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onCreateMediaInfo(
    _CreateMediaInfo event,
    Emitter<MediaInfoState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    return emit(
      state.copyWith(
        status: Status.success,
        mediaInfo: await _imageUseCase.updateMediaInfo(
          mediaInfo: MediaInfo(
            likes: [],
            tags: event.tags,
            mediaId: event.mediaId,
          ),
        ),
      ),
    );
  }
}
