import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/text_editing_tool_bar.dart';
import 'package:uuid/uuid.dart';

class TextInputOverlay extends StatefulWidget {
  final Function() onTextSubmitted;
  const TextInputOverlay({super.key,required this.onTextSubmitted});

  @override
  State<TextInputOverlay> createState() => _TextInputOverlayState();
}

class _TextInputOverlayState extends State<TextInputOverlay> {
  late FocusNode _textFocusNode;
  late TextEditingController _textEditingController;
  String initialText = '';
  final _uuid= Uuid().v4();

  @override
  void initState() {
    final cubit = context.read<TextEditingCubit>();
    initialText = cubit.state.positionedTextElement.text;
    _textFocusNode = FocusNode();
    _textEditingController = TextEditingController(text: initialText);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_textFocusNode);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
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
                  if (_textFocusNode.hasFocus) {
                    _textFocusNode.unfocus();
                    context.read<TextEditingCubit>().addTextAlignment(
                      PositionedTextElement(
                        scale:state.positionedTextElement.scale ,
                        textPropertiesForStory: state.textPropertiesForStory,
                        offset: state.positionedTextElement.offset,
                        id: _uuid,
                        rotation: state.positionedTextElement.rotation,
                        positionedElementStoryTheme:
                            null,
                        size: state.positionedTextElement.size,
                        text: _textEditingController.text,
                      ),
                    );
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
                    focusNode: _textFocusNode,
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
                      context.read<TextEditingCubit>().addTextAlignment(
                        PositionedTextElement(
                          scale:state.positionedTextElement.scale ,
                          textPropertiesForStory: state.textPropertiesForStory,
                          offset: state.positionedTextElement.offset,
                          id: Uuid().v4(),
                          rotation: state.positionedTextElement.rotation,
                          positionedElementStoryTheme:
                          null,
                          size: state.positionedTextElement.size,
                          text: _textEditingController.text,
                        ),
                      );
                      widget.onTextSubmitted();
                      _textFocusNode.unfocus(); // Dismiss keyboard
                    },
                  ),
                ),
              ),
            ),

            // Text Editing Toolbar (Vertical on left)
            TextEditingToolbar(),
          ],
        );
      },
    );
  }
}
