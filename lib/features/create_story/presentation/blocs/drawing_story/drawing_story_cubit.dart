import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/drawing_story/drawing_story_state.dart';

class DrawingStoryCubit extends Cubit<DrawingState> {
  DrawingStoryCubit() : super(DrawingState());

  void undoDrawing() {
    if (state.lines.isNotEmpty) {
      var newList = [...state.lines];
      newList.removeLast();
      emit(state.copyWith(lines: newList));
    }
  }

  void clearDrawing() {
    emit(state.copyWith(lines: [], currentPoints: []));
  }

  void changeDrawingColor(Color color) {
    emit(state.copyWith(lineColor: color));
  }

  void changeStrokeWidth(double width) {
    emit(state.copyWith(strokeWidth: width));
  }

  void changeCurrentLine(List<Offset> points) {
    emit(state.copyWith(currentPoints: points));
  }
  void emptyCurrentPoints() {
    emit(state.copyWith(currentPoints: []));
  }
  void addNewLine(Offset points) {
    List<Offset> newLines = [...state.currentPoints];
    newLines.add(points);
    emit(state.copyWith(currentPoints: newLines));
  }

  addDrawingElement() {
    final DrawingElement drawingElement = DrawingElement(
      color: state.lineColor,
      points: List.from(state.currentPoints),
      strokeWidth: state.strokeWidth,
    );
    List<DrawingElement> newList = List.from(state.lines);
    newList.add(drawingElement);
    emit(state.copyWith(lines: newList));
  }
}
