import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_state.dart';


class UploadPictureCubit extends Cubit<UploadPictureState> {
  UploadPictureCubit() : super(UploadPictureState.empty());
  void setPicture(File image) {
    emit(state.copyWith(
        image: image,
        uploadPictureStatus: UploadPictureStatus.init,
        errorMessage: ''));
  }
  void setCoverPicture(File image) {
    emit(state.copyWith(
        coverImage: image,
        uploadPictureStatus: UploadPictureStatus.init,
        errorMessage: ''));
  }
}
