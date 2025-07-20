import 'package:flutter/material.dart';

class MediaGrid extends StatelessWidget {
  final Map<String, List<String>> groupedMedia;

  const MediaGrid({super.key, required this.groupedMedia});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          groupedMedia.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    entry.key,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: entry.value.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    return Image.network(entry.value[index], fit: BoxFit.cover);
                  },
                ),
              ],
            );
          }).toList(),
    );
  }
}
