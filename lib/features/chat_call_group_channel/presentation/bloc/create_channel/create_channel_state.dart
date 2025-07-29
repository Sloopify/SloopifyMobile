class CreateChannelState {
  final bool isLoading;
  final String? imagePath; // Changed from File? imageFile
  final String? inviteLink;

  const CreateChannelState({
    this.isLoading = false,
    this.imagePath,
    this.inviteLink,
  });

  CreateChannelState copyWith({
    bool? isLoading,
    String? imagePath,
    String? inviteLink,
  }) {
    return CreateChannelState(
      isLoading: isLoading ?? this.isLoading,
      imagePath: imagePath ?? this.imagePath,
      inviteLink: inviteLink ?? this.inviteLink,
    );
  }
}
