import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';

import 'shimmer_widget.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final Widget? placeholder;
  final double? width;
  final double? height;

  CachedImage(
      {required this.imageUrl,
      this.fit,
      this.placeholder,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheKey: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
           ShimmerWidget.rectangular(
            height: height??100,
            width: width??100,
          ),
      errorWidget: (context, url, error) => Container(
        padding: EdgeInsets.all(AppPadding.p8),
        width: width,
        height: height,
        child: placeholder
      ),
      imageUrl: imageUrl ?? '',
      fit: fit ?? BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
