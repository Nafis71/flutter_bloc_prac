import 'package:equatable/equatable.dart';

abstract class GalleryPickerEvent extends Equatable {
  const GalleryPickerEvent();

  @override
  List<Object?> get props => [];
}

class CameraCapture extends GalleryPickerEvent {}

class GalleryImagePicker extends GalleryPickerEvent {}
