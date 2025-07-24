import 'package:flutter/material.dart';

class MediaSection extends StatelessWidget {
  final List<String> media;

  const MediaSection({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              'Media, Links, Documents',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.chevron_right),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 64,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: media.length,
            itemBuilder:
                (_, i) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    media[i],
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
            separatorBuilder: (_, __) => const SizedBox(width: 8),
          ),
        ),
      ],
    );
  }
}
