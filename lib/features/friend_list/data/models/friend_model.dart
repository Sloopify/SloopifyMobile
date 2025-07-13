import '../../domain/entities/friend.dart';

class FriendModel extends Friend {
  FriendModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.isFriend,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      isFriend: json['isFriend'],
    );
  }
}
