class GroupPermissionState {
  final bool canEditSettings;
  final bool canSendMessages;
  final bool canAddMembers;

  const GroupPermissionState({
    this.canEditSettings = false,
    this.canSendMessages = true,
    this.canAddMembers = false,
  });

  GroupPermissionState copyWith({
    bool? canEditSettings,
    bool? canSendMessages,
    bool? canAddMembers,
  }) {
    return GroupPermissionState(
      canEditSettings: canEditSettings ?? this.canEditSettings,
      canSendMessages: canSendMessages ?? this.canSendMessages,
      canAddMembers: canAddMembers ?? this.canAddMembers,
    );
  }
}
