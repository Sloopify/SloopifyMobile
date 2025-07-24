import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/text_properties_story.dart';

class TextEditingState extends Equatable {
  final TextPropertiesForStory textPropertiesForStory;
   PositionedTextElement positionedTextElement;
  final List<PositionedTextElement> allTextAlignment;
  final bool isEditingExistingText;
  final bool fromTextStory;

  TextEditingState({
    required this.positionedTextElement,
    required this.textPropertiesForStory,
    required this.allTextAlignment,
    required this.isEditingExistingText,
    required this.fromTextStory
  });

  factory TextEditingState.fromEmpty() {
    return TextEditingState(
      fromTextStory: false,
      isEditingExistingText: false,
      positionedTextElement: PositionedTextElement.empty(),
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
    bool? fromTextStory
  }) {
    return TextEditingState(
      fromTextStory:fromTextStory??this.fromTextStory ,
      isEditingExistingText: isEditingPositionedText??isEditingExistingText,
      positionedTextElement:newOne?? positionedTextElement.copyWith(
        text: text ?? positionedTextElement.text,
        size: size ?? positionedTextElement.size,
        positionedElementStoryTheme: null,
        rotation: rotation ?? positionedTextElement.rotation,
        offset: offset ?? positionedTextElement.offset,
        textProperty: textPropertiesForStory.copyWith(
            color: color ?? textPropertiesForStory.color,
            fontSize: fontSize ?? textPropertiesForStory.fontSize,
            underline: underline ?? textPropertiesForStory.underline,
            italic: italic ?? textPropertiesForStory.italic,
            fontType: fontType ?? textPropertiesForStory.fontType,
            bold: bold ?? textPropertiesForStory.bold,
            alignment: alignment??textPropertiesForStory.alignment
        ),
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
  List<Object?> get props => [textPropertiesForStory,positionedTextElement,allTextAlignment,isEditingExistingText];
}
