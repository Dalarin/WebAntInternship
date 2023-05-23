part of 'image_picker_bloc.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();
}

class ImagePickerInitial extends ImagePickerState {
  @override
  List<Object> get props => [];
}
