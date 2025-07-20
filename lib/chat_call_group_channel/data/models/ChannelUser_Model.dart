enum ChannelRole { owner, admin, member }

class ChannelUser {
  final String id;
  final String name;
  final String avatarUrl;
  final ChannelRole role;

  ChannelUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.role,
  });
}
