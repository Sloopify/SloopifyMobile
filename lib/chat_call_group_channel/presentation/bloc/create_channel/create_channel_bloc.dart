import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';
import 'create_channel_event.dart';
import 'create_channel_state.dart';

class CreateChannelBloc extends Bloc<CreateChannelEvent, CreateChannelState> {
  final picker = ImagePicker();

  CreateChannelBloc() : super(CreateChannelState()) {
    on<PickImage>(_onPickImage);
    on<SubmitChannel>(_onSubmitChannel);
  }

  Future<void> _onPickImage(
    PickImage event,
    Emitter<CreateChannelState> emit,
  ) async {
    final picked = await picker.pickImage(
      source: event.fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (picked != null) {
      final cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [AndroidUiSettings(toolbarTitle: 'Crop Image')],
      );
      if (cropped != null) {
        emit(state.copyWith(imageFile: File(cropped.path)));
      }
    }
  }

  void _onSubmitChannel(
    SubmitChannel event,
    Emitter<CreateChannelState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    final inviteLink = 'https://sloopify.com/channels/ch=${Uuid().v4()}/invite';
    emit(state.copyWith(isLoading: false, inviteLink: inviteLink));
  }
}
