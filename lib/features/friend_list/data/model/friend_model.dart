import '../../domain/entities/friend.dart';

class FriendModel {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isFriend;

  FriendModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isFriend,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'].toString(),
      name: json['name'],
      avatarUrl: json['avatar_url'] ?? '',
      isFriend: json['is_friend'] ?? false,
    );
  }

  Friend toEntity() {
    return Friend(id: id, name: name, avatarUrl: avatarUrl, isFriend: isFriend);
  }
}
