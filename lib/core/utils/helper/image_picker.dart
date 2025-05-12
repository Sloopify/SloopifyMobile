import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sloopify_mobile/core/utils/helper/toast_utils.dart';


Future<File?> pickImage(BuildContext context, ImageSource source) async {
  try {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return null;
    final imageTemp = File(image.path);
    return imageTemp;
  } on Exception {
    ToastUtils.showErrorToastMessage(
      'some thing went wrong!,try again.',
    );
  }
  return null;
}

Future showPickerImageSheet(BuildContext context) async {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text('camera',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith()),
              ),
              ListTile(
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                leading: const Icon(Icons.image_outlined),
                title: Text('gallery',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith()),
              ),
            ],
          ),
        ],
      );
    },
  );
}
