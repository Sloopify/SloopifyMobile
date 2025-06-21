import 'dart:ui';

import 'package:equatable/equatable.dart';

class TextPropertyEntity extends Equatable {
  final bool isBold;
  final bool isUnderLine;
  final bool isItalic;
  final String? color;

  const TextPropertyEntity({
    this.color,
    required this.isUnderLine,
    required this.isItalic,
    required this.isBold,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isBold, isItalic, isUnderLine, color];

  factory TextPropertyEntity.empty() {
    return TextPropertyEntity(
      isUnderLine: false,
      isItalic: false,
      isBold: false,
      color: null,
    );
  }

  TextPropertyEntity copyWith({
    bool? isBold,
    bool? isUnderLine,
    bool? isItalic,
    String? color,
  }) {
    return TextPropertyEntity(
      isUnderLine: isUnderLine ?? this.isUnderLine,
      isItalic: isItalic ?? this.isItalic,
      isBold: isBold ?? this.isBold,
      color: color ?? this.color,
    );
  }

  toJson({bool withMedia=false}) {
    return {
      "bold": withMedia? boolToInt(isBold): isBold,
      "italic":withMedia? boolToInt(isItalic):isItalic ,
      "underline": withMedia? boolToInt(isUnderLine):isUnderLine,
      if (color != null && color!.isNotEmpty && color!="#null") "color": color,
    };
  }
  int boolToInt(bool? value) => (value ?? false) ? 1 : 0;
}
