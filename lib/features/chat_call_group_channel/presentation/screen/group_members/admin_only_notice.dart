import 'package:flutter/material.dart';

class AdminOnlyNotice extends StatelessWidget {
  const AdminOnlyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: const [
          Icon(Icons.block, color: Colors.grey),
          SizedBox(height: 8),
          Text(
            "Only Group's admin can send message",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
