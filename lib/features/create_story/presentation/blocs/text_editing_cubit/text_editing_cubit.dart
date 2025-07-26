import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/core/ui/widgets/text_editor_widget.dart';
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
    emit(state.copyWith(newOne: element));
    List<PositionedTextElement> newList = List.from(state.allTextAlignment);
    newList.add(element);
    print(newList);
    emit(state.copyWith(allTextAlignment: newList));
  }

  void updateTextElement(PositionedTextElement element) {
    final updatedList = List<PositionedTextElement>.from(
      state.allTextAlignment,
    );

    final index = state.allTextAlignment.indexWhere((e) => e.id == element.id);
    if (index != -1) {
      updatedList[index] = element;
      state.allTextAlignment[index] = element;
      emit(state.copyWith(allTextAlignment: updatedList));
    }
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

  void updateSelectedPositionedText(PositionedTextElement element) {
    state.positionedTextElement = element;
    final updatedList = List<PositionedTextElement>.from(
      state.allTextAlignment,
    );
    final index = updatedList.indexWhere((e) => e.id == element.id);
    if (index != -1) {
      emit(state.copyWith(newOne: element));
      state.allTextAlignment[index] = element;
      updatedList[index] = element;
      state.allTextAlignment[index] = element;
    }
    emit(state.copyWith(allTextAlignment: updatedList));
  }

  void setEditingExistingText(bool editing) {
    emit(state.copyWith(isEditingPositionedText: editing));
  }

  void clearCurrentText() {
    emit(TextEditingState.fromEmpty());
  }

  void setFromTextEditor() {
    emit(state.copyWith(fromTextStory: true));
  }

  void clearAll() {
    emit(TextEditingState.fromEmpty());
  }

  void updateTextContent(String newText) {
    emit(state.copyWith(text: newText));
  }

  void removeTextElement(String id) {
    final List<PositionedTextElement> current = state.allTextAlignment;
    current.removeWhere((element) => element.id == id);
    emit(state.copyWith(allTextAlignment: current));
  }

  void removeOnlyOneTextElement(String id) {
    state.positionedTextElement = PositionedTextElement.empty();
    emit(state.copyWith(newOne: PositionedTextElement.empty()));
  }
}
