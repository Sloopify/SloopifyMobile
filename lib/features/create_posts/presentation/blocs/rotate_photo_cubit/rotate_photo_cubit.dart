import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/rotate_photo_cubit/rotate_photo_state.dart';

import 'package:bloc/bloc.dart';

import '../../../domain/entities/media_entity.dart';


class RotateMediaCubit extends Cubit<RotateMediaState> {
  RotateMediaCubit({required MediaEntity initialEntity, })
      : super(RotateMediaState(mediaEntity: initialEntity));

  void rotateRight() {
    final currentAngle = state.mediaEntity.rotateAngle ?? 0;
    emit(state.copyWith(
      mediaEntity: state.mediaEntity.copyWith(
        rotateAngle: (currentAngle + 90) % 360,
        isRotate: true,
      ),
    ));
  }

  void rotateLeft() {
    final currentAngle = state.mediaEntity.rotateAngle ?? 0;
    emit(state.copyWith(
      mediaEntity: state.mediaEntity.copyWith(
        rotateAngle: (currentAngle - 90) % 360,
        isRotate: true,
      ),
    ));
  }

  void flipHorizontal() {
    emit(state.copyWith(
      mediaEntity: state.mediaEntity.copyWith(
        isFlipHorizontal: !(state.mediaEntity.isFlipHorizontal??false),
      ),
    ));
  }

  void flipVertical() {
    emit(state.copyWith(
      mediaEntity: state.mediaEntity.copyWith(
        isFlipVertical: !(state.mediaEntity.isFlipVertical??false),
      ),
    ));
  }

  void reset() {
    emit(state.copyWith(mediaEntity: state.mediaEntity.copyWith(
        isFlipHorizontal: false,
        isFlipVertical: false,
        isRotate: false,
        rotateAngle: 0.0)));
  }
}