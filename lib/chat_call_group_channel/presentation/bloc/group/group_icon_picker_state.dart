class GroupIconState {
  final String? imagePath;
  final bool isCropping;

  const GroupIconState({this.imagePath, this.isCropping = false});

  factory GroupIconState.initial() => const GroupIconState();

  GroupIconState copyWith({String? imagePath, bool? isCropping}) {
    return GroupIconState(
      imagePath: imagePath ?? this.imagePath,
      isCropping: isCropping ?? this.isCropping,
    );
  }
}
