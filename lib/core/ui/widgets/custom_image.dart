// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/ui/widgets/shimmer_widget.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final bool? isCircle;
  final double? radius;
  final BoxFit fit;
  final bool isPersonalImage;

  const CustomImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.isCircle,
    this.radius,
    this.isPersonalImage = false,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCircle == true
        ? CachedNetworkImage(
      useOldImageOnUrlChange: false,
      imageUrl: image,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          ShimmerWidget.circular(
            height: 50,
            width: 50,
          ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error,
        ),
      ),
      imageBuilder: (context, imageProvider) => PhysicalModel(
        color: Colors.grey.withOpacity(0.3),
        elevation: 4.0,
        shape: BoxShape.circle,
        child: CircleAvatar(
          radius: radius!,
          backgroundImage: CachedNetworkImageProvider(
            image,
          ),
        ),
      ),
    )
        : CachedNetworkImage(
      imageUrl: image,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(
            child: SizedBox(
              width: width,
              height: height,
              child: Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
            ),
          ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error,
        ),
      ),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: isCircle == null || isCircle == false
              ? BoxShape.rectangle
              : BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
    );
  }
}
