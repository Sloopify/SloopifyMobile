import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';

class DrawingState extends Equatable {
  List<Offset> currentPoints;
  final List<DrawingElement> lines;
  final Color lineColor;
  final double strokeWidth;

  DrawingState({
    this.currentPoints = const [],
    this.strokeWidth = 3.0,
    this.lineColor = Colors.white,
    this.lines = const [],
  });

  @override
  // TODO: implement props
  List<Object?> get props => [currentPoints,strokeWidth,lineColor,lines];

  DrawingState copyWith({  List<Offset>? currentPoints,
   List<DrawingElement>? lines,
   Color ? lineColor,
   double? strokeWidth,}){
    return DrawingState(
      currentPoints: currentPoints??this.currentPoints,
      strokeWidth: strokeWidth??this.strokeWidth,
      lineColor: lineColor??this.lineColor,
      lines: lines??this.lines
    );

  }
}
