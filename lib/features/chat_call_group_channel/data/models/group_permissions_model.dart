class GroupPermissions {
  final bool canEditSettings;
  final bool canSendMessages;
  final bool canAddMembers;

  GroupPermissions({
    this.canEditSettings = false,
    this.canSendMessages = true,
    this.canAddMembers = false,
  });

  GroupPermissions copyWith({
    bool? canEditSettings,
    bool? canSendMessages,
    bool? canAddMembers,
  }) {
    return GroupPermissions(
      canEditSettings: canEditSettings ?? this.canEditSettings,
      canSendMessages: canSendMessages ?? this.canSendMessages,
      canAddMembers: canAddMembers ?? this.canAddMembers,
    );
  }
}
