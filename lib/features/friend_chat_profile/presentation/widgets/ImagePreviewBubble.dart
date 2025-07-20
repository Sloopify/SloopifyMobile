import 'package:flutter/material.dart';

class ImagePreviewBubble extends StatelessWidget {
  final String imageUrl;
  const ImagePreviewBubble({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(imageUrl, width: 200),
    );
  }
}
