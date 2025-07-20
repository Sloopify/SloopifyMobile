import 'package:flutter/material.dart';

class VoiceMessageBubble extends StatelessWidget {
  final String audioUrl;
  const VoiceMessageBubble({required this.audioUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.play_arrow, color: Colors.white),
        Text("Voice message", style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
