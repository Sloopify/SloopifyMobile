import 'dart:io';
import 'dart:ui';

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

  FeelingElement copyWith({
    int? feelingId,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    double? scale,
    String? feelingName,
    String? feelingIcon
  }) {
    return FeelingElement(
      feelingName: feelingName ?? this.feelingName,
      feelingId: feelingId ?? this.feelingId,
      rotation: rotation ?? this.rotation,
      offset: offset ?? this.offset,
      feelingIcon: feelingIcon??this.feelingIcon,
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
      'weather_code': weatherCode,
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
}

class AudioElement extends PositionedElement {
  final int audioId;

  AudioElement({
    required this.audioId,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
    required super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'audio_id': audioId, ...super.toJson()};
  }

  AudioElement copyWith({
    double? value,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    int? audioId,
    double? scale,
  }) {
    return AudioElement(
      audioId: audioId ?? this.audioId,
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

class PollElement extends PositionedElement {
  final String question;
  final List<String> options;

  PollElement({
    required this.question,
    required this.options,
    required super.offset,
    required super.id,
    required super.rotation,
    required super.positionedElementStoryTheme,
    required super.size,
    required super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'question': question, 'options': options, ...super.toJson()};
  }

  PollElement copyWith({
    double? value,
    PositionedElementStoryTheme? positionedElementStoryTheme,
    Offset? offset,
    double? rotation,
    Size? size,
    String? question,
    List<String>? options,
    double? scale,
  }) {
    return PollElement(
      options: options ?? this.options,
      question: question ?? this.question,
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
  final String clockTheme;

  ClockElement({
    required super.offset,
    super.positionedElementStoryTheme,
    super.size,
    super.rotation,
    required super.id,
    required this.clockTheme,
    required this.dateTime,
    required super.scale,
  });

  @override
  Map<String, dynamic> toJson() {
    return {"clock": '${dateTime.hour}: ${dateTime.minute}', "clockTheme": ""};
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
      clockTheme: theme ?? this.clockTheme,
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
      'color': color.value,
      'strokeWidth': strokeWidth,
    };
  }
}
