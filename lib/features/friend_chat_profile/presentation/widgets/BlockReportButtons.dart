import 'package:flutter/material.dart';

class BlockReportButtons extends StatelessWidget {
  const BlockReportButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          leading: Icon(Icons.block, color: Colors.red),
          title: Text("Block", style: TextStyle(color: Colors.red)),
        ),
        ListTile(
          leading: Icon(Icons.thumb_down, color: Colors.red),
          title: Text("Report", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
