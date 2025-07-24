import 'package:flutter/material.dart';

class RecordingWidget extends StatelessWidget {
  final VoidCallback onStop;

  const RecordingWidget({super.key, required this.onStop});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[50],
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.mic, color: Colors.red),
          const SizedBox(width: 8),
          const Expanded(child: Text("Recording... 00:12")),
          IconButton(icon: const Icon(Icons.stop), onPressed: onStop),
        ],
      ),
    );
  }
}
