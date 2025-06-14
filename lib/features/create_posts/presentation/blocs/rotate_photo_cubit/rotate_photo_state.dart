class RotateEditState {
  final double rotationAngle; // in degrees
  final bool isFlippedHorizontal;
  final bool isFlippedVertical;

  const RotateEditState({
    this.rotationAngle = 0,
    this.isFlippedHorizontal = false,
    this.isFlippedVertical = false,
  });

  RotateEditState copyWith({
    double? rotationAngle,
    bool? isFlippedHorizontal,
    bool? isFlippedVertical,
  }) {
    return RotateEditState(
      rotationAngle: rotationAngle ?? this.rotationAngle,
      isFlippedHorizontal: isFlippedHorizontal ?? this.isFlippedHorizontal,
      isFlippedVertical: isFlippedVertical ?? this.isFlippedVertical,
    );
  }
}