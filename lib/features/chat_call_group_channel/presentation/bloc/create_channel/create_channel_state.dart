import 'dart:io';

class CreateChannelState {
  final File? imageFile;
  final bool isLoading;
  final String? inviteLink;

  CreateChannelState({this.imageFile, this.isLoading = false, this.inviteLink});

  CreateChannelState copyWith({
    File? imageFile,
    bool? isLoading,
    String? inviteLink,
  }) {
    return CreateChannelState(
      imageFile: imageFile ?? this.imageFile,
      isLoading: isLoading ?? this.isLoading,
      inviteLink: inviteLink ?? this.inviteLink,
    );
  }
}
