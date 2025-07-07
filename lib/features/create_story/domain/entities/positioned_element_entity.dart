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
     this.positionedElementStoryTheme=PositionedElementStoryTheme.white,
     this.size,
     this.rotation,
     this.scale,
  });

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
