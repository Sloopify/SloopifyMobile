import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/text_editing_tool_bar.dart';

class TextInputOverlay extends StatefulWidget {
  final String initialText;
  final Color? initialColor;
  final String? initialFontTypeString;
  final bool? initialBold;
  final bool? initialItalic;
  final bool? initialUnderline;
  final String? initialAlignmentString;

  final Function(String text) onTextSubmitted;
  final Function(Color? color) onColorChanged;
  final Function(String? fontType) onFontTypeStringChanged;
  final Function(bool? bold) onBoldChanged;
  final Function(bool? italic) onItalicChanged;
  final Function(bool? underline) onUnderlineChanged;
  final Function(String? alignment) onAlignmentStringChanged;

  const TextInputOverlay({
    super.key,
    required this.initialText,
    required this.initialColor,
    required this.initialFontTypeString,
    required this.initialBold,
    required this.initialItalic,
    required this.initialUnderline,
    required this.initialAlignmentString,
    required this.onTextSubmitted,
    required this.onColorChanged,
    required this.onFontTypeStringChanged,
    required this.onBoldChanged,
    required this.onItalicChanged,
    required this.onUnderlineChanged,
    required this.onAlignmentStringChanged,
  });

  @override
  State<TextInputOverlay> createState() => _TextInputOverlayState();
}

class _TextInputOverlayState extends State<TextInputOverlay> {
  late FocusNode _textFocusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _textEditingController = TextEditingController(text: widget.initialText);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_textFocusNode);
    });
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
      case 'left': return TextAlign.left;
      case 'center': return TextAlign.center;
      case 'right': return TextAlign.right;
      default: return TextAlign.center;
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
    return (underline ?? false) ? TextDecoration.underline : TextDecoration.none;
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the center of the screen for text input
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textInputPosition = Offset(screenWidth / 2, screenHeight / 2);

    return Stack(
      children: [
        // GestureDetector to dismiss keyboard when tapping outside TextField
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              if (_textFocusNode.hasFocus) {
                _textFocusNode.unfocus();
                widget.onTextSubmitted(_textEditingController.text);
              }
            },
            child: Container(color: Colors.transparent), // Transparent container to capture taps
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
                textAlign: _stringToTextAlign(widget.initialAlignmentString),
                autofocus: true,
                style: TextStyle(
                  color: widget.initialColor,
                  fontSize: 24, // Assuming a fixed font size for input
                  fontWeight: _getFontWeight(widget.initialBold),
                  fontStyle: _getFontStyle(widget.initialItalic),
                  decoration: _getTextDecoration(widget.initialUnderline),
                  fontFamily: widget.initialFontTypeString,
                ),
                decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: "write something",
                  hintStyle: TextStyle(
                    color: widget.initialColor?.withOpacity(0.7),
                    fontSize: 24,
                    fontWeight: _getFontWeight(widget.initialBold),
                    fontStyle: _getFontStyle(widget.initialItalic),
                    decoration: _getTextDecoration(widget.initialUnderline),
                    fontFamily: widget.initialFontTypeString,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                onSubmitted: (text) {
                  widget.onTextSubmitted(text);
                  _textFocusNode.unfocus(); // Dismiss keyboard
                },
              ),
            ),
          ),
        ),

        // Text Editing Toolbar (Vertical on left)
        TextEditingToolbar(
          currentColor: widget.initialColor,
          currentFontTypeString: widget.initialFontTypeString,
          currentBold: widget.initialBold,
          currentItalic: widget.initialItalic,
          currentUnderline: widget.initialUnderline,
          currentAlignmentString: widget.initialAlignmentString,
          onColorStringChanged: widget.onColorChanged,
          onFontTypeStringChanged: widget.onFontTypeStringChanged,
          onBoldChanged: widget.onBoldChanged,
          onItalicChanged: widget.onItalicChanged,
          onUnderlineChanged: widget.onUnderlineChanged,
          onAlignmentStringChanged: widget.onAlignmentStringChanged,
        ),
      ],
    );
  }
}
