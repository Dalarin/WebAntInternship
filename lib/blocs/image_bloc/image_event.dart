part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class GetImages extends ImageEvent {
  final bool popular;
  final bool newMedia;
  final bool newRequest;

  const GetImages({
    this.popular = false,
    this.newMedia = false,
    this.newRequest = false,
  });
}


class UploadImage extends ImageEvent {

}
