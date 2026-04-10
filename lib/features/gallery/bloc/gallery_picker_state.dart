import 'package:equatable/equatable.dart';

enum GalleryStatus{loading, success}
class GalleryPickerState extends Equatable {
  final List<String>? images;
  final GalleryStatus? status;

  const GalleryPickerState({this.images, this.status});

  @override
  List<Object?> get props => [images,status];

  GalleryPickerState copyWith({
    List<String>? images,
    GalleryStatus? status,
  }) {
    return GalleryPickerState(
      images: images ?? this.images,
      status: status ?? this.status,
    );
  }
}
