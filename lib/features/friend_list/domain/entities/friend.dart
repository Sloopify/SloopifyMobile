import 'package:flutter/widgets.dart';

class Friend {
  final String id;
  final String name;
  final Image avatarUrl;
  final bool isFriend;

  Friend({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isFriend,
  });
}
