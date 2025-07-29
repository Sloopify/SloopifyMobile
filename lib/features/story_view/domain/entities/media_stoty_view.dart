import 'dart:ui';

import 'package:equatable/equatable.dart';

class MediaStoryView extends Equatable {
  final String id;
  final String type;
  final String url;
  final int order;
  final double rotateAngle;
  final double scale;
  final Offset offset;
  final Size size;

  MediaStoryView({
    required this.size,
    required this.offset,
    required this.id,
    required this.rotateAngle,
    required this.scale,
    required this.type,
    required this.order,
    required this.url,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        size,
        offset,
        id,
        scale,
        type,
        order,
        url,
        rotateAngle,
      ];

  factory MediaStoryView.fromJson(Map<String, dynamic> json){
    return MediaStoryView(size: Size(double.parse(
        json["metadata"]["width"]), double.parse(json["metadata"]["height"]),),
        offset: Offset(double.parse(json["dx"]), double.parse(json["dy"])),
        id: json["id"],
        rotateAngle: double.parse(json["rotate_angle"]),
        scale: double.parse(json["scale"]),
        type: json["type"],
        order: int.parse(json["order"]),
        url: json["url"]);
  }
}
