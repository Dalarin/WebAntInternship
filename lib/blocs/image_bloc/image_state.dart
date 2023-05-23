part of 'image_bloc.dart';

class ImageState extends Equatable {
  final List<Media> media;
  final Status status;
  final ErrorEnum errorEnum;
  final String? message;
  final bool hasReachedEnd;

  const ImageState({
    this.media = const <Media>[],
    this.status = Status.initial,
    this.hasReachedEnd = false,
    this.message,
    this.errorEnum = ErrorEnum.all,
  });

  ImageState copyWith({
    List<Media>? media,
    Status? status,
    String? message,
    bool? hasReachedEnd,
    ErrorEnum? errorEnum,
  }) {
    return ImageState(
      media: media ?? this.media,
      status: status ?? this.status,
      message: message ?? this.message,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorEnum: errorEnum ?? this.errorEnum,
    );
  }

  @override
  List<Object?> get props => [media, status, message];
}

