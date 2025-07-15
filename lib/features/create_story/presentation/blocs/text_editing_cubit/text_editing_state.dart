import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/text_properties_story.dart';

class TextEditingState extends Equatable {
  final TextPropertiesForStory textPropertiesForStory;
  final PositionedTextElement positionedTextElement;
  final List<PositionedTextElement> allTextAlignment;
  final bool isEditingExistingText;

  TextEditingState({
    required this.positionedTextElement,
    required this.textPropertiesForStory,
    required this.allTextAlignment,
    required this.isEditingExistingText
  });

  factory TextEditingState.fromEmpty() {
    return TextEditingState(
      isEditingExistingText: false,
      positionedTextElement: PositionedTextElement(
        textPropertiesForStory: TextPropertiesForStory.empty(),
        offset: Offset(0, 0),
        id: '',
        scale: 1,
        rotation: 0.0,
        positionedElementStoryTheme: null,
        size: Size.zero,
        text: "",
      ),
      textPropertiesForStory: TextPropertiesForStory.empty(),
      allTextAlignment: []
    );
  }

  TextEditingState copyWith({
    Color? color,
    String? fontType,
    bool? bold,
    bool? italic,
    bool? underline,
    String? alignment,
    double? fontSize,
    Offset? offset,
    Size? size,
    double? rotation,
    TextPropertiesForStory? textProperty,
    String? text,
    List<PositionedTextElement>? allTextAlignment,
    PositionedTextElement? newOne,
    bool ? isEditingPositionedText,
  }) {
    return TextEditingState(
      isEditingExistingText: isEditingPositionedText??isEditingExistingText,
      positionedTextElement:newOne?? positionedTextElement.copyWith(
        text: text ?? positionedTextElement.text,
        size: size ?? positionedTextElement.size,
        positionedElementStoryTheme: null,
        rotation: rotation ?? positionedTextElement.rotation,
        offset: offset ?? positionedTextElement.offset,
        textProperty: textPropertiesForStory,
      ),
      textPropertiesForStory: textPropertiesForStory.copyWith(
        color: color ?? textPropertiesForStory.color,
        fontSize: fontSize ?? textPropertiesForStory.fontSize,
        underline: underline ?? textPropertiesForStory.underline,
        italic: italic ?? textPropertiesForStory.italic,
        fontType: fontType ?? textPropertiesForStory.fontType,
        bold: bold ?? textPropertiesForStory.bold,
        alignment: alignment??textPropertiesForStory.alignment
      ),
      allTextAlignment: allTextAlignment??this.allTextAlignment,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [textPropertiesForStory,positionedTextElement,allTextAlignment];
}
