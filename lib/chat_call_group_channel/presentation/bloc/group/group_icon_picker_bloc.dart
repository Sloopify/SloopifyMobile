import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_icon_picker_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_icon_picker_state.dart';

class GroupIconBloc extends Bloc<GroupIconEvent, GroupIconState> {
  final ImagePicker _picker = ImagePicker();

  GroupIconBloc() : super(const GroupIconState()) {
    on<PickFromGallery>(_onPickFromGallery);
    on<CaptureFromCamera>(_onCaptureFromCamera);
    on<CropImage>(_onCropImage);
  }

  Future<void> _onPickFromGallery(
    PickFromGallery event,
    Emitter<GroupIconState> emit,
  ) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      add(CropImage(image.path));
    }
  }

  Future<void> _onCaptureFromCamera(
    CaptureFromCamera event,
    Emitter<GroupIconState> emit,
  ) async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      add(CropImage(image.path));
    }
  }

  Future<void> _onCropImage(
    CropImage event,
    Emitter<GroupIconState> emit,
  ) async {
    emit(state.copyWith(isCropping: true));
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: event.imagePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),

      uiSettings: [
        AndroidUiSettings(toolbarTitle: 'Crop Image'),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );
    if (croppedFile != null) {
      emit(state.copyWith(imagePath: croppedFile.path, isCropping: false));
    } else {
      emit(state.copyWith(isCropping: false));
    }
  }
}
