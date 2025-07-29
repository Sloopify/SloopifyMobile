import 'dart:io';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/poll_entity_option.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/text_properties_story.dart';

import '../../../../core/utils/helper/postioned_element_story_theme.dart';

class PositionedElementWithLocationId extends PositionedElement {
  final int locationId;
  final String countryName;
  final String cityName;

  const PositionedElementWithLocationId({
    required this.locationId,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
    required super.scale,
    required this.countryName,
    required this.cityName,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': locationId,
      'country_name': countryName,
      "city_name": cityName,
      ...super.toJson(),
    };
  }

  PositionedElementWithLocationId copyWith({
    int? locationId,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    Size? size,
    double? rotation,
    double? scale,
    String? countryName,
    String? cityName,
  }) {
    return PositionedElementWithLocationId(
      cityName: cityName ?? this.cityName,
      countryName: countryName ?? this.countryName,
      rotation: rotation ?? this.rotation,
      id: id,
      locationId: locationId ?? this.locationId,
      offset: offset ?? this.offset,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
    );
  }

  factory PositionedElementWithLocationId.fromJson(Map<String, dynamic> json) {
    return PositionedElementWithLocationId(
      id: "",
      locationId: int.parse(json["id"]),
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme: json["theme"].getValuesFromApi(),
      countryName: json["country_name"],
      cityName: json["city_name"],
    );
  }
}

class PositionedMentionElement extends PositionedElement {
  final int friendId;
  final String friendName;

  PositionedMentionElement({
    required this.friendId,
    super.offset,
    required super.id,
    super.rotation,
    super.positionedElementStoryTheme,
    super.size,
    super.scale,
    required this.friendName,
  });

  factory PositionedMentionElement.fromJson(Map<String, dynamic> json) {
    return PositionedMentionElement(
      friendId: int.parse(json["friend_id"]),
      id: "",
      friendName: json["friend_name"],
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme: json["theme"].getValuesFromApi(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'friend_id': friendId,
      'friend_name': friendName,
      ...super.toJson(),
    };
  }

  @override
  PositionedMentionElement copyWith({
    int? friendId,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    Size? size,
    double? rotation,
    double? scale,
    String? friendName,
  }) {
    return PositionedMentionElement(
      friendName: friendName ?? this.friendName,
      id: id,
      friendId: friendId ?? this.friendId,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
    );
  }
}

class PositionedTextElement extends PositionedElement {
  final TextPropertiesForStory textPropertiesForStory;
  final String text;

  PositionedTextElement({
    required this.textPropertiesForStory,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
    required super.scale,
    required this.text,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'text_properties': textPropertiesForStory.toJson(),
      'text': text,
      ...super.toJson(),
    };
  }

  factory PositionedTextElement.fromJson(Map<String, dynamic> json) {
    return PositionedTextElement(
      id: "",
      textPropertiesForStory:
          json["text_properties"] != null
              ? TextPropertiesForStory.fromJson(json["text_properties"])
              : TextPropertiesForStory.empty(),
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme: json["theme"].getValuesFromApi(),
      text: json["text"] ?? "",
    );
  }

  PositionedTextElement copyWith({
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    Size? size,
    double? rotation,
    TextPropertiesForStory? textProperty,
    String? text,
    double? scale,
  }) {
    return PositionedTextElement(
      text: text ?? this.text,
      textPropertiesForStory: textProperty ?? textPropertiesForStory,
      id: id,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
    );
  }

  factory PositionedTextElement.empty() {
    return PositionedTextElement(
      textPropertiesForStory: TextPropertiesForStory.empty(),
      offset: Offset.zero,
      id: '',
      rotation: 0.0,
      positionedElementStoryTheme: null,
      size: Size.zero,
      scale: 1.0,
      text: "",
    );
  }
}

class FeelingElement extends PositionedElement {
  final int feelingId;
  final String feelingName;
  final String feelingIcon;

  FeelingElement({
    required this.feelingId,
    required this.feelingName,
    required this.feelingIcon,
    required super.offset,
    required super.positionedElementStoryTheme,
    required super.rotation,
    required super.id,
    required super.size,
    required super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'feeling_id': feelingId,
      'feeling_name': feelingName,
      ...super.toJson(),
    };
  }

  factory FeelingElement.fromJson(Map<String, dynamic> json) {
    return FeelingElement(
      id: "",
      positionedElementStoryTheme:
          json["theme"] != null ? json["theme"].getValuesFromApi() : null,
      feelingId: int.parse(json["feeling_id"]),
      feelingName: json["feeling_name"],
      feelingIcon: "",
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
    );
  }

  FeelingElement copyWith({
    int? feelingId,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    double? scale,
    String? feelingName,
    String? feelingIcon,
  }) {
    return FeelingElement(
      feelingName: feelingName ?? this.feelingName,
      feelingId: feelingId ?? this.feelingId,
      rotation: rotation ?? this.rotation,
      offset: offset ?? this.offset,
      feelingIcon: feelingIcon ?? this.feelingIcon,
      id: id,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
    );
  }
}

class TemperatureElement extends PositionedElement {
  final double value;
  final dynamic weatherCode;
  final bool isDay;

  const TemperatureElement({
    required this.value,
    required this.isDay,
    required this.weatherCode,
    super.offset,
    required super.id,
    super.rotation,
    super.positionedElementStoryTheme,
    super.size,
    super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'weather_code': weatherCode.toString(),
      'isDay': isDay,
      ...super.toJson(),
    };
  }

  TemperatureElement copyWith({
    double? value,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    double? scale,
    num? weatherCode,
    bool? isDay,
  }) {
    return TemperatureElement(
      isDay: isDay ?? this.isDay,
      weatherCode: weatherCode ?? this.weatherCode,
      id: id,
      value: value ?? this.value,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
    );
  }

  factory TemperatureElement.empty() {
    return const TemperatureElement(
      weatherCode: 0,
      isDay: true,
      value: 0.0,
      offset: Offset.zero,
      id: '',
      rotation: 0.0,
      positionedElementStoryTheme: null,
      size: null,
      scale: null,
    );
  }

  factory TemperatureElement.fromJson(Map<String, dynamic> json) {
    return TemperatureElement(
      value: double.tryParse(json["value"]) ?? 0.0,
      isDay: json["isDay"],
      weatherCode: int.tryParse(json["weather_code"]) ?? 0,
      id: "",
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme:
          json["theme"] != null ? json["theme"].getValuesFromApi() : null,
    );
  }
}

class AudioElement extends PositionedElement {
  final int audioId;
  final String audioName;
  final String audioImage;
  final String audioUrl;

  AudioElement({
    required this.audioId,
    required this.audioName,
    required this.audioImage,
    required this.audioUrl,
    super.offset,
    required super.id,
    super.rotation,
    super.positionedElementStoryTheme,
    super.size,
    super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'audio_id': audioId,
      "audio_name": audioName,
      "audio_image": audioImage,
      "audio_url": audioUrl,
      ...super.toJson(),
    };
  }

  AudioElement copyWith({
    double? value,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    int? audioId,
    double? scale,
    String? audioName,
    String? audioImage,
    String? audioUrl,
  }) {
    return AudioElement(
      audioUrl: audioUrl ?? this.audioUrl,
      audioId: audioId ?? this.audioId,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      id: id,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
      audioImage: audioImage ?? this.audioImage,
      audioName: audioName ?? this.audioName,
    );
  }

  factory AudioElement.fromJson(Map<String, dynamic> json) {
    return AudioElement(
      audioId: int.parse(json["audio_id"]),
      audioName: json["audio_name"],
      audioImage: json["audio_image"],
      audioUrl: json["audio_url"],
      id: "",
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme:
          json["theme"] != null ? json["theme"].getValuesFromApi() : null,
    );
  }
}

class PollElement extends PositionedElement {
  final Poll poll;

  PollElement({
    required this.poll,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
    required super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'question': poll.question,
      'poll_options': poll.options.map((e) => e.toJson()).toList(),
      ...super.toJson(),
    };
  }

  factory PollElement.fromJson(Map<String, dynamic> json) {
    return PollElement(
      poll:
          json["poll_element"] != null
              ? Poll.fromJson(json["poll_element"])
              : Poll.fromEmpty(),
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme:
          json["theme"] != null ? json["theme"].getValuesFromApi() : null,
      id: '',
    );
  }

  PollElement copyWith({
    double? value,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    double? scale,
    Poll? poll,
  }) {
    return PollElement(
      poll: poll ?? this.poll,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      id: id,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
    );
  }
}

class StickerElement extends PositionedElement {
  final String gifUrl;

  StickerElement({
    required this.gifUrl,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
    required super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'gif_url': gifUrl, ...super.toJson()};
  }

  factory StickerElement.fromJson(Map<String, dynamic> json) {
    return StickerElement(
      gifUrl: json["gif_url"],
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme:
          json["theme"] != null ? json["theme"].getValuesFromApi() : null,
      id: '',
    );
  }

  StickerElement copyWith({
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    String? gifUrl,
    double? scale,
  }) {
    return StickerElement(
      gifUrl: gifUrl ?? this.gifUrl,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      id: id,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
    );
  }
}

class ClockElement extends PositionedElement {
  final DateTime dateTime;

  ClockElement({
    required super.offset,
    super.positionedElementStoryTheme,
    super.size,
    super.rotation,
    required super.id,
    required this.dateTime,
    required super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), "clock": '${dateTime.hour}:${dateTime.minute}'};
  }

  factory ClockElement.fromJson(Map<String, dynamic> json) {
    return ClockElement(
      rotation:
          json["rotation"] != null ? double.tryParse(json["rotation"]) : 0.0,
      scale: json["scale"] != null ? double.tryParse(json["scale"]) : 1.0,
      offset:
          json["x"] == null && json["y"] == null
              ? Offset.zero
              : Offset(double.parse(json["x"]), double.parse(json["y"])),
      size: Size(double.parse(json["size_x"]), double.parse(json["size_h"])),
      positionedElementStoryTheme:
          json["theme"] != null ? json["theme"].getValuesFromApi() : null,
      id: '',
      dateTime: DateTime.parse(json['clock']),
    );
  }

  ClockElement copyWith({
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    Size? size,
    double? rotation,
    DateTime? time,
    String? theme,
    double? scale,
  }) {
    return ClockElement(
      dateTime: time ?? dateTime,
      id: id,
      offset: offset ?? this.offset,
      rotation: rotation ?? this.rotation,
      positionedElementStoryTheme:
          positionedElementStoryTheme ?? this.positionedElementStoryTheme,
      size: size ?? this.size,
      scale: scale ?? this.scale,
    );
  }
}

class DrawingElement {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  DrawingElement({
    required this.color,
    required this.points,
    required this.strokeWidth,
  });

  DrawingElement copyWith({
    List<Offset>? points,
    Color? color,
    double? strokeWidth,
  }) {
    return DrawingElement(
      color: color ?? this.color,
      points: points ?? this.points,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points.map((p) => {'x': p.dx, 'y': p.dy}).toList(),
      'stroke_color':
          '#${(color.value & 0x00FFFFFF).toRadixString(16).padLeft(6, '0')}',
      'stroke_width': strokeWidth,
    };
  }

  factory DrawingElement.fromJson(Map<String, dynamic> json) {
    return DrawingElement(
      color: json["stroke_color"],
      points: List.generate(
        json["points"].length,
        (index) => Offset(
          double.parse(json["points"][index]["x"]),
          double.parse(json["points"][index]["y"]),
        ),
      ),
      strokeWidth: double.parse(json["stroke_width"]),
    );
  }
}

class LinePoints extends Equatable {
  final double x;

  final double y;

  LinePoints({required this.x, required this.y});

  @override
  // TODO: implement props
  List<Object?> get props => [x, y];

  factory LinePoints.fromJson(Map<String, dynamic> json) {
    return LinePoints(x: double.parse(json["x"]), y: double.parse(json["y"]));
  }
}
