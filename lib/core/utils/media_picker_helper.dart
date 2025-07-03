import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'helper/permission_helper.dart';
class MediaPickerService {
  final ImagePicker _picker = ImagePicker();
  Future<File?> pickImageFromGallery() async {
    if (await Permissions.requestGalleryPermission()) {
      final XFile? image = await _picker.pickImage(source:
      ImageSource.gallery);
      return image != null ? File(image.path) : null;
    }
    return null;
  }

  Future<File?> pickImageFromCamera() async {
    if (await Permissions.requestCameraPermission()) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      return image != null ? File(image.path) : null;
    }
    return null;
  }

Future<File?> pickVideoFromGallery() async {
  if (await Permissions.requestGalleryPermission()) {
    final XFile? video = await _picker.pickVideo(source:
    ImageSource.gallery);
    return video != null ? File(video.path) : null;
  }
  return null;
}
Future<File?> pickVideoFromCamera() async {
  if (await Permissions.requestCameraPermission()) {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    return video != null ? File(video.path) : null;
  }
  return null;
}

}