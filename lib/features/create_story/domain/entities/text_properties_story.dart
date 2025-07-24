import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextPropertiesForStory extends Equatable {
  final Color? color;
  final String? fontType;
  final bool? bold;
  final bool? italic;
  final bool? underline;
  final String? alignment;
  final double? fontSize;

  const TextPropertiesForStory({
    required this.color,
    required this.fontType,
    required this.bold,
    required this.italic,
    required this.underline,
    required this.alignment,
    required this.fontSize,
  });

  factory TextPropertiesForStory.fromJson(Map<String, dynamic> json) {
    return TextPropertiesForStory(
      fontSize: json["fontSize"],
      color: json['color'],
      fontType: json['font_type'],
      bold: json['bold'] ?? false,
      italic: json['italic'] ?? false,
      underline: json['underline'] ?? false,
      alignment: json['alignment'],
    );
  }

  factory TextPropertiesForStory.empty() {
    return TextPropertiesForStory(
      color: Colors.white,
      fontType: 'Roboto',
      bold: false,
      italic: false,
      underline: false,
      fontSize: 24,
      alignment: 'center',
    );
  }

  TextPropertiesForStory copyWith({
    Color? color,
    String? fontType,
    bool? bold,
    bool? italic,
    bool? underline,
    String? alignment,
    double? fontSize,
  }) {
    return TextPropertiesForStory(
      color: color ?? this.color,
      fontType: fontType ?? this.fontType,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
      underline: underline ?? this.underline,
      alignment: alignment ?? this.alignment,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (color != null) {
      data["color"] = '${(color!.value & 0x00FFFFFF).toRadixString(16).padLeft(6, '0')}';
    }
    if (fontType != null) {
      data["font_type"] = fontType;
    }
    if (bold != null) {
      data["bold"] = bold;
    }
    if (italic != null) {
      data["italic"] = italic;
    }
    if (underline != null) {
      data["underline"] = underline;
    }
    if (alignment != null) {
      data["alignment"] = alignment;
    }

    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    color,
    fontType,
    bold,
    italic,
    underline,
    alignment,
  ];
}
