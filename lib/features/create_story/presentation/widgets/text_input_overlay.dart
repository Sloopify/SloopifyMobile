import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
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
  String initialText = '';
  final _uuid = Uuid().v4();

  @override
  void initState() {
    final cubit = context.read<TextEditingCubit>();
    initialText = cubit.state.positionedTextElement.text;
    _textEditingController = TextEditingController(text: initialText);
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
                      context.read<TextEditingCubit>().submitText(
                        _textEditingController.text,
                      );

                    widget.focusNode.unfocus();
                    widget.onTextSubmitted();
                  }
                },
                child: Container(
                  color: Colors.transparent,
                ), // Transparent container to capture taps
              ),
            ),
            // Text Input Field
            Positioned(
              left: 0,
              right: 0,
              top: textInputPosition.dy - 25, // Adjust for TextField height
              child: Center(
                child: IntrinsicWidth(
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: widget.focusNode,
                    textAlign: _stringToTextAlign(
                      state.textPropertiesForStory.alignment,
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
                      final cubit = context.read<TextEditingCubit>();
                      final state = cubit.state;

                      if (state.isEditingExistingText) {
                        // Edit mode: update existing text in list
                        final updated = state.positionedTextElement.copyWith(
                          text: _textEditingController.text,
                          textProperty: state.textPropertiesForStory,
                        );

                        final updatedList = List<PositionedTextElement>.from(
                          state.allTextAlignment,
                        );
                        final index = updatedList.indexWhere(
                          (e) => e.id == updated.id,
                        );
                        if (index != -1) {
                          updatedList[index] = updated;

                          cubit.emit(
                            state.copyWith(
                              allTextAlignment: updatedList,
                              isEditingPositionedText: false, // reset to normal
                            ),
                          );
                        }
                      } else {
                        // New text
                        final newText = PositionedTextElement(
                          id: Uuid().v4(),
                          text: _textEditingController.text,
                          textPropertiesForStory: state.textPropertiesForStory,
                          offset: Offset(100, 100),
                          scale: 1.0,
                          rotation: 0.0,
                          size: Size.zero,
                          positionedElementStoryTheme: null,
                        );

                        cubit.addTextAlignment(newText);
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
