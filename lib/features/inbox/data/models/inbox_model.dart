class InboxModel {
  final String name;
  final String message;
  final String time;
  final bool unread;
  final String avatarUrl;

  InboxModel({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.avatarUrl,
  });
}
