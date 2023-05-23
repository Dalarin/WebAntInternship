part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();
}

class PickImageFromSource extends ImagePickerEvent {
  final ImageSource source;

  const PickImageFromSource(this.source);

  @override
  List<Object> get props => [source];
}
