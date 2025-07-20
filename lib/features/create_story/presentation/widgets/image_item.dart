
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';


class ImageWidget extends StatelessWidget {
  final MediaEntity mediaEntity;

  const ImageWidget({super.key, required this.mediaEntity});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform:
          Matrix4.identity()
            ..rotateZ((mediaEntity.rotateAngle ?? 0.0) * 3.1415926535 / 180)
            ..scale(
              (mediaEntity.isFlipHorizontal ?? false) ? -1.0 : 1.0,
              (mediaEntity.isFlipVertical ?? false) ? -1.0 : 1.0,
            ),
      child: Image.file(mediaEntity.file!, fit: BoxFit.contain),
    );
  }
}
