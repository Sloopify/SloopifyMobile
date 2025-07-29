import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/core/utils/helper/postioned_element_story_theme.dart';

class PositionedElement extends Equatable {
  final String id;
  final Offset? offset;
  final PositionedElementStoryTheme? positionedElementStoryTheme;
  final Size? size;
  final double? rotation;
  final double? scale;

  const PositionedElement({
    required this.id,
    this.offset,
    this.positionedElementStoryTheme = PositionedElementStoryTheme.white,
    this.size,
    this.rotation,
    this.scale,
  });

   PositionedElement fromJson(Map<String, dynamic> json) {
    return PositionedElement(
      id: "",
      rotation:json["rotation"]!=null? double.tryParse(json["rotation"]):0.0,
      scale: json["scale"]!=null?double.tryParse(json["scale"]):1.0,
      offset: json["x"]==null && json["y"]==null? Offset.zero:Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme:
         getValuesFromApi(json["theme"]),
    );
  }

  static PositionedElementStoryTheme getValuesFromApi(String theme) {
    switch (theme) {
      case "theme_1":
        return PositionedElementStoryTheme.white;
      case "theme_2":
        return  PositionedElementStoryTheme.normalWithBorder;
      case "theme_3" :
        return PositionedElementStoryTheme.focusedWithPrimaryColor;
      case "theme_4":
        return PositionedElementStoryTheme.focusedWithPrimaryShade ;
      default:
        return PositionedElementStoryTheme.white;
    }
  }

  PositionedElement copyWith({
    Offset? offset,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Size? size,
    double? rotation,
    double? scale,
  }) {
    return PositionedElement(
      id: id,
      offset: offset ?? this.offset,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      rotation: rotation ?? this.rotation,
      scale: scale ?? this.scale,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (offset?.dx != null) {
      data["x"] = offset?.dx;
    }
    if (offset?.dy != null) {
      data["y"] = offset?.dy;
    }
    if (positionedElementStoryTheme != null) {
      data["theme"] = positionedElementStoryTheme?.getValuesForApi();
    }
    if (size?.width != null) {
      data["size_x"] = size!.width;
    }
    if (size?.height != null) {
      data["size_h"] = size!.height;
    }
    if (rotation != null) {
      data["rotation"] = rotation;
    }
    if (scale != null) {
      data["scale"] = scale;
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    positionedElementStoryTheme,
    size,
    offset,
    id,
    rotation,
    scale,
  ];
}
