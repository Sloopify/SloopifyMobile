import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/rotate_photo_cubit/rotate_photo_state.dart';

class RotateEditCubit extends Cubit<Map<int, RotateEditState>> {
  RotateEditCubit() : super({});

  void rotateLeft(int index) {
    final current = state[index] ?? const RotateEditState();
    final newAngle = (current.rotationAngle - 90) % 360;
    emit({...state, index: current.copyWith(rotationAngle: newAngle)});
  }

  void rotateRight(int index) {
    final current = state[index] ?? const RotateEditState();
    final newAngle = (current.rotationAngle + 90) % 360;
    emit({...state, index: current.copyWith(rotationAngle: newAngle)});
  }

  void flipHorizontal(int index) {
    final current = state[index] ?? const RotateEditState();
    emit({...state, index: current.copyWith(isFlippedHorizontal: !current.isFlippedHorizontal)});
  }

  void flipVertical(int index) {
    final current = state[index] ?? const RotateEditState();
    emit({...state, index: current.copyWith(isFlippedVertical: !current.isFlippedVertical)});
  }
}