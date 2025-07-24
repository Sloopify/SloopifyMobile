import 'package:flutter/material.dart';

class GroupEventChip extends StatelessWidget {
  final String message;

  const GroupEventChip(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Chip(backgroundColor: Colors.grey.shade200, label: Text(message)),
    );
  }
}
