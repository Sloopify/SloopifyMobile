import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import 'cached_image.dart';


class GeneralImage extends StatelessWidget {
  final double? cornerRadius;
  final bool viewInFullScreen;
  final double? width;
  final double? height;
  final dynamic image;
  final Widget? placeHolder;
  final bool isNetworkImage;
  final BoxDecoration? decoration;
  final BorderRadius? borderRadius;
  final Color? color;
  final BoxFit? fit;
  final bool? svg;
  final String? svgAssets;
  final bool withAppBar;
  final String? titleOfImage;
  final String? noText;

  const GeneralImage._({
    this.cornerRadius,
    this.viewInFullScreen = false,
    this.image,
    this.borderRadius,
    this.width,
    this.height,
    this.placeHolder,
    this.isNetworkImage = true,
    this.decoration,
    this.color,
    this.fit,
    this.svg,
    this.svgAssets,
    this.withAppBar=false,
    this.titleOfImage,
    this.noText
  });

  factory GeneralImage.circular(
      {required double radius,
        bool viewInFullScreen = false,
        dynamic image,
        Widget? placeHolder,
        BorderRadius? borderRadius,
        BoxDecoration? decoration,
        isNetworkImage = true,
        Color? color,
        BoxFit? fit,
        String? svgAssets,
        String? titleOfImage,
        bool withAppBar=false,
        String? noText,
        svg = false}) =>
      GeneralImage._(
        viewInFullScreen: viewInFullScreen,
        image: image,
        cornerRadius: radius,
        height: radius,
        width: radius,
        borderRadius: borderRadius,
        isNetworkImage: isNetworkImage,
        svg: svg,
        placeHolder: placeHolder,
        decoration: decoration,
        color: color,
        fit: fit,
        svgAssets: svgAssets,
        titleOfImage: titleOfImage,
        withAppBar: withAppBar,
        noText: noText,
      );

  factory GeneralImage.rectangle({
    double? cornerRadius,
    required dynamic image,
    bool viewInFullScreen = false,
    double? width,
    double? height,
    BorderRadius? borderRadius,
    Widget? placeHolder,
    BoxDecoration? decoration,
    BoxFit? fit,
    Color? color,
    isNetworkImage = false,
    svg = false,
    String? svgAssets,
    String? titleOfImage,
    String? noText,
    bool withAppBar=false,
  }) =>
      GeneralImage._(
        image: image,
        viewInFullScreen: viewInFullScreen,
        cornerRadius: cornerRadius,
        height: height,
        width: width,
        color: color,
        borderRadius: borderRadius,
        isNetworkImage: isNetworkImage,
        placeHolder: placeHolder ?? Container(),
        decoration: decoration ?? const BoxDecoration(),
        fit: fit ?? BoxFit.contain,
        svg: svg,
        svgAssets: svgAssets,
        withAppBar: withAppBar,
        titleOfImage: titleOfImage,
        noText: noText,
      );

  viewImageInFullScreen(context) async {
    final Image imageFile;
    if (isNetworkImage) {
      final fileInfo = await DefaultCacheManager().getFileFromCache(image);
      imageFile = Image.file(fileInfo!.file);
      if (image != null) {

      }
    } else {
      // imageFile = image is File
      //     ? Image.file(
      //         image, //File(image.path),
      //         fit: fit ?? BoxFit.fill,
      //       )
      //     : Image.asset(
      //         image ?? svgAssets ?? AppAssets.person,
      //         fit: fit ?? BoxFit.fill,
      //         color: color,
      //       );
      //
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ViewImage(
      //       noText: noText,
      //       withAppBar: withAppBar,
      //       titleOfImage: titleOfImage,
      //       image: null,
      //       heroTag: null,
      //     ),
      //   ),
      // );
    }

  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      width: width,
      height: height,
      decoration: decoration,
      child: ClipRRect(
        borderRadius:
        borderRadius ?? BorderRadius.circular(cornerRadius ?? 0.0),
        child: image == null
            ? svgAssets != null
            ? SvgPicture.asset(svgAssets!)
            : SizedBox.shrink() //TODO
            : isNetworkImage == true
            ? CachedImage(
          height:height,
          width: width,
          imageUrl: image!,
          placeholder: placeHolder,
          fit: fit ?? BoxFit.fill,
        )
            : svg!
            ? SvgPicture.asset(
          image!,
          color: color,
          fit: fit ?? BoxFit.fill,
        )
            : image is File
            ? Image.file(
          image, //File(image.path),
          fit: fit ?? BoxFit.fill,
        )
            : Image.asset(
          image!,
          fit: fit ?? BoxFit.fill,
          color: color,
        ),
      ),
    );
    return (viewInFullScreen )
        ? GestureDetector(
      onTap:
      viewInFullScreen ? () => viewImageInFullScreen(context) : () {},
      child: child,
    )
        : child;
  }
}
