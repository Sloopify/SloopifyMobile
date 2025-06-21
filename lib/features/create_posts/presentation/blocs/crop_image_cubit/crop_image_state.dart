import 'dart:io';

import '../../../domain/entities/media_entity.dart';


class CropState {
final MediaEntity mediaEntity;
final File ?originFile;
  CropState({required this.mediaEntity,required this.originFile});

  CropState copyWith( {MediaEntity? mediaEntity,File?originFile}) {
    return CropState(mediaEntity: mediaEntity ?? this.mediaEntity,originFile: originFile??this.originFile);
  }

}
