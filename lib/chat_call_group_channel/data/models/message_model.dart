import 'package:flutter/material.dart';

class Message {
  final String senderName;
  final String groupName;
  final String userAvatar;
  final String content;
  final String timestamp;
  final IconData statusIcon;

  Message({
    required this.senderName,
    required this.groupName,
    required this.userAvatar,
    required this.content,
    required this.timestamp,
    required this.statusIcon,
  });
}
