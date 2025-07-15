import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/text_properties_story.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_state.dart';

class TextEditingCubit extends Cubit<TextEditingState> {
  TextEditingCubit() : super(TextEditingState.fromEmpty());

  // Text Editing Callbacks (now using String? and bool?)

  void changeCurrentTextColor(Color color) {
    emit(state.copyWith(color: color));
  }

  void changeCurrentFontType(String fontType) {
    emit(state.copyWith(fontType: fontType));
  }

  void toggleCurrentTextBold() {
    emit(state.copyWith(bold: !(state.textPropertiesForStory.bold ?? false)));
  }

  void toggleCurrentTextItalic() {
    emit(
      state.copyWith(italic: !(state.textPropertiesForStory.italic ?? false)),
    );
  }

  void toggleCurrentTextUnderline() {
    emit(
      state.copyWith(
        underline: !(state.textPropertiesForStory.underline ?? false),
      ),
    );
  }

  void changeCurrentTextAlignmentString(String alignment) {
    emit(state.copyWith(alignment: alignment));
  }

  void addTextAlignment(PositionedTextElement element) {
    List<PositionedTextElement> newList = List.from(state.allTextAlignment);
    newList.add(element);
    emit(state.copyWith(allTextAlignment: newList));
  }

  void changeTextOffset(Offset offsets) {
    emit(state.copyWith(offset: offsets));
  }

  void changeTextRotation(double rotation) {
    emit(state.copyWith(rotation: rotation));
  }

  void changeTextFontSize(double fontSize) {
    emit(state.copyWith(fontSize: fontSize));
  }

  void updateSelectedPositionedText(String id) {
    final currentElement =
        state.allTextAlignment.where((e) => e.id == id).first;
    emit(state.copyWith(newOne: currentElement));
  }
  void setEditingExistingText(bool editing) {
    emit(state.copyWith(isEditingPositionedText: editing));
  }

  void clearCurrentText() {
    emit(TextEditingState.fromEmpty());
  }
  void submitText(String newText) {
    final updated = state.positionedTextElement.copyWith(text: newText);
    emit(state.copyWith(
        newOne: updated,
        isEditingPositionedText:true,
        ));
  }
}
