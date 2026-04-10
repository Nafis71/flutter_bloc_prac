import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker _picker = ImagePicker();
  static ImagePickerUtils? _instance;

  ImagePickerUtils._();

  factory ImagePickerUtils() => _instance ??= ImagePickerUtils._();

  Future<XFile?> captureImage() async {
    try {
      return await _picker.pickImage(source: .camera);
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  Future<XFile?> pickImageFromGallery() async {
    try {
      return await _picker.pickImage(source: .gallery);
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }
}
