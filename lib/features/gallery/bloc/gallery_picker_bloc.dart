import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_prac/core/utils/image_picker_utils.dart';
import 'package:flutter_bloc_prac/features/gallery/bloc/gallery_picker_event.dart';
import 'package:flutter_bloc_prac/features/gallery/bloc/gallery_picker_state.dart';
import 'package:image_picker/image_picker.dart';

class GalleryPickerBloc extends Bloc<GalleryPickerEvent, GalleryPickerState> {
  final ImagePickerUtils _imagePickerUtils;

  GalleryPickerBloc(this._imagePickerUtils)
    : super(GalleryPickerState(images: [])) {
    on<CameraCapture>(_captureImage);
    on<GalleryImagePicker>(_pickImageFromGallery);
  }

  Future<void> _captureImage(
    CameraCapture cameraCapture,
    Emitter<GalleryPickerState> emit,
  ) async {
    XFile? file = await _imagePickerUtils.captureImage();
    if (file != null) {
      emit(state.copyWith(status: GalleryStatus.loading));
      List<String>? images = [...state.images ?? []];
      images.add(file.path);
      emit(state.copyWith(images: images, status: GalleryStatus.success));
    }
  }

  Future<void> _pickImageFromGallery(
    GalleryImagePicker cameraCapture,
    Emitter<GalleryPickerState> emit,
  ) async {
    XFile? file = await _imagePickerUtils.pickImageFromGallery();
    if (file != null) {
      emit(state.copyWith(status: GalleryStatus.loading));
      List<String>? images = [...state.images ?? []];
      images.add(file.path);
      await Future.delayed(Duration(seconds: 2));
      emit(state.copyWith(images: images, status: GalleryStatus.success));
    }
  }
}
