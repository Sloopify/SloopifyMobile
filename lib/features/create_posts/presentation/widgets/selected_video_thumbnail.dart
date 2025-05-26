import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectedVideoItem extends StatelessWidget {
  final AssetEntity asset;
  final VoidCallback onTap;

  const SelectedVideoItem({
    Key? key,
    required this.asset,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailDataWithSize(ThumbnailSize(300, 300)),
      builder: (_, snapshot) {
        final hasData = snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null;

        return GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                  image: hasData
                      ? DecorationImage(
                    image: MemoryImage(snapshot.data!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: !hasData ? Center(child: CircularProgressIndicator()) : null,
              ),
              if (hasData)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 40),
                ),
            ],
          ),
        );
      },
    );
  }
}