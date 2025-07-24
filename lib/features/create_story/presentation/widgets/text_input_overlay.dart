import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/text_editing_tool_bar.dart';
import 'package:uuid/uuid.dart';

class TextInputOverlay extends StatefulWidget {
  final Function() onTextSubmitted;
  FocusNode focusNode;
  final bool fromTextStory;

  TextInputOverlay({
    super.key,
    required this.onTextSubmitted,
    required this.focusNode,
    this.fromTextStory = false,
  });

  @override
  State<TextInputOverlay> createState() => _TextInputOverlayState();
}

class _TextInputOverlayState extends State<TextInputOverlay> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(
      text: context.read<TextEditingCubit>().state.positionedTextElement.text,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(widget.focusNode);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // Helper to convert string alignment to TextAlign for TextField
  TextAlign _stringToTextAlign(String? alignString) {
    switch (alignString?.toLowerCase()) {
      case 'left':
        return TextAlign.left;
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.center;
    }
  }

  // Helper to get font weight
  FontWeight _getFontWeight(bool? bold) {
    return (bold ?? false) ? FontWeight.bold : FontWeight.normal;
  }

  // Helper to get font style
  FontStyle _getFontStyle(bool? italic) {
    return (italic ?? false) ? FontStyle.italic : FontStyle.normal;
  }

  // Helper to get text decoration
  TextDecoration _getTextDecoration(bool? underline) {
    return (underline ?? false)
        ? TextDecoration.underline
        : TextDecoration.none;
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<TextEditingCubit>().state.positionedTextElement.text);
    // Calculate the center of the screen for text input
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textInputPosition = Offset(screenWidth / 2, screenHeight / 2);
    return BlocBuilder<TextEditingCubit, TextEditingState>(
      builder: (context, state) {
        return Stack(
          children: [
            // GestureDetector to dismiss keyboard when tapping outside TextField
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  if (widget.focusNode.hasFocus) {
                    widget.focusNode.unfocus();
                    widget.onTextSubmitted();
                  } else {
                    return;
                  }
                },
                child: Container(
                  color: Colors.transparent,
                ), // Transparent container to capture taps
              ),
            ),
            // Text Input Field
            Positioned(
              left: 10,
              right: 10,
              top: textInputPosition.dy - 50, // Adjust for TextField height
              child: Center(
                child: IntrinsicWidth(
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: widget.focusNode,
                    textAlign: _stringToTextAlign(
                      state
                          .positionedTextElement
                          .textPropertiesForStory
                          .alignment,
                    ),
                    autofocus: true,
                    style: TextStyle(
                      color: state.textPropertiesForStory.color,
                      fontSize: state.textPropertiesForStory.fontSize,
                      // Assuming a fixed font size for input
                      fontWeight: _getFontWeight(
                        state.textPropertiesForStory.bold,
                      ),
                      fontStyle: _getFontStyle(
                        state.textPropertiesForStory.italic,
                      ),
                      decoration: _getTextDecoration(
                        state.textPropertiesForStory.underline,
                      ),
                      fontFamily: state.textPropertiesForStory.fontType,
                    ),
                    decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintText: "write something",
                      hintStyle: TextStyle(
                        color: state.textPropertiesForStory.color,
                        fontSize: state.textPropertiesForStory.fontSize,
                        // Assuming a fixed font size for input
                        fontWeight: _getFontWeight(
                          state.textPropertiesForStory.bold,
                        ),
                        fontStyle: _getFontStyle(
                          state.textPropertiesForStory.italic,
                        ),
                        decoration: _getTextDecoration(
                          state.textPropertiesForStory.underline,
                        ),
                        fontFamily: state.textPropertiesForStory.fontType,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (text) {
                      final newText = PositionedTextElement(
                        id: Uuid().v4(),
                        text: _textEditingController.text,
                        textPropertiesForStory: state.textPropertiesForStory,
                        offset: Offset(
                          (MediaQuery.of(context).size.width / 2),
                          (MediaQuery.of(context).size.height / 2),
                        ),
                        scale: 1.0,
                        rotation: 0.0,
                        size: Size.zero,
                        positionedElementStoryTheme: null,
                      );
                      if (state.isEditingExistingText) {
                        final updatedText = state.positionedTextElement
                            .copyWith(text: text);
                        print(updatedText.text);
                        context
                            .read<TextEditingCubit>()
                            .updateSelectedPositionedText(updatedText);
                        if (state.fromTextStory) {
                          context.read<StoryEditorCubit>().updateOneTextElement(
                            newElement: updatedText,
                          );
                        }
                      } else {
                        context.read<TextEditingCubit>().addTextAlignment(
                          newText,
                        );
                        if (state.fromTextStory) {
                          context.read<StoryEditorCubit>().updateOneTextElement(
                            newElement: newText,
                          );
                        }
                      }
                      widget.onTextSubmitted(); // hide overlay
                      widget.focusNode.unfocus();
                    },
                  ),
                ),
              ),
            ),

            // Text Editing Toolbar (Vertical on left)
            if (!widget.fromTextStory) TextEditingToolbar(),
          ],
        );
      },
    );
  }
}
