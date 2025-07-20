import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/user.dart';

class Channel {
  final String id;
  final String name;
  final String description;
  final bool isFollowed;
  final String imageUrl;

  // Add this temporarily for EditAdminsScreen
  final List<User> admins;
  final List<User> friends;

  Channel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isFollowed = false,
    this.admins = const [],
    this.friends = const [],
  });

  Channel copyWith({
    String? id,
    String? name,
    String? description,
    bool? isFollowed,
    String? imageUrl,
    List<User>? admins,
    List<User>? friends,
  }) {
    return Channel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isFollowed: isFollowed ?? this.isFollowed,
      admins: admins ?? this.admins,
      friends: friends ?? this.friends,
    );
  }
}
