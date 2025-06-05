import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_profile_image_use_case.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_state.dart';

import '../../../../../core/errors/failures.dart';


class UploadPictureCubit extends Cubit<UploadPictureState> {
final CompleteProfileImageUseCase completeProfileImageUseCase;
  UploadPictureCubit({required this.completeProfileImageUseCase}) : super(UploadPictureState.empty());
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

   submit() async{
    emit(state.copyWith(uploadPictureStatus: UploadPictureStatus.loading));
    final res =await completeProfileImageUseCase.call(image: state.image!);
    res.fold((f){
      _mapFailureToState(emit, f, state);

    }, (r){
      emit(state.copyWith(uploadPictureStatus: UploadPictureStatus.done));
    });

  }
_mapFailureToState(emit, Failure f, UploadPictureState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          uploadPictureStatus: UploadPictureStatus.noInternet,
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          uploadPictureStatus: UploadPictureStatus.networkError,
          errorMessage: f.message,
        ),
      );
  }
}
}
