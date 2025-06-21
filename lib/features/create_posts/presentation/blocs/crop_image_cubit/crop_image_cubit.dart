import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/media_entity.dart';
import 'crop_image_state.dart';

class CropCubit extends Cubit<CropState> {
  CropCubit({required MediaEntity mediaEntity }) : super(CropState(mediaEntity: mediaEntity,originFile: mediaEntity.file));

  void setCroppedImage( File file) {
    emit(state.copyWith(mediaEntity: state.mediaEntity.copyWith(file: file)));

  }
  void resetOriginalFile(){
    emit(state.copyWith(mediaEntity: state.mediaEntity.copyWith(file: state.originFile)));
  }
}