import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/core/utils/helper/postioned_element_story_theme.dart';

class PositionedElement extends Equatable {
  final String id;
  final Offset? offset;
  final PositionedElementStoryTheme? positionedElementStoryTheme;
  final Size? size;
  final double ? rotation;

  const PositionedElement({
    required this.id,
    required this.offset,
    required this.positionedElementStoryTheme,
    required this.size,
    required this.rotation
  });


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
    if (size != null) {
      data["size"] = size;
    }
    if (rotation != null) {
      data["rotation"] = rotation;
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [positionedElementStoryTheme,size,offset,id,rotation];
}
