import 'package:flutter/widgets.dart';

class UserModel {
  final String name;
  final Image avatarUrl;
  final String status;

  UserModel({
    required this.name,
    required this.avatarUrl,
    required this.status,
  });
}
