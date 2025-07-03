import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/create_story/domain/all_positioned_element.dart';

class EditableTextElement extends StatefulWidget {
  final PositionedTextElement textElement;
  final Function(PositionedTextElement updatedElement) onElementChanged;

  const EditableTextElement({
    Key? key,
    required this.textElement,
    required this.onElementChanged,
  }) : super(key: key);

  @override
  State<EditableTextElement> createState() => _EditableTextElementState();
}

class _EditableTextElementState extends State<EditableTextElement> {
  late Offset _currentOffset;
  late double _currentRotation;
  late double _currentFontSize;

  // Initial values for gesture calculations
  late Offset _initialGestureOffset;
  late double _initialGestureRotation;
  late double _initialGestureFontSize;

  @override
  void initState() {
    super.initState();
    _currentOffset = widget.textElement.offset!;
    _currentRotation = widget.textElement.rotation!;
    _currentFontSize = widget.textElement.textPropertiesForStory.fontSize ?? 24.0;
  }

  @override
  void didUpdateWidget(covariant EditableTextElement oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update internal state if the parent widget passes a new textElement
    if (widget.textElement != oldWidget.textElement) {
      _currentOffset = widget.textElement.offset!;
      _currentRotation = widget.textElement.rotation!;
      _currentFontSize = widget.textElement.textPropertiesForStory.fontSize ?? 24.0;
    }
  }

  // Helper to convert string color to Flutter Color object
  Color _stringToColor(String? colorString) {
    switch (colorString?.toLowerCase()) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'yellow': return Colors.yellow;
      case 'purple': return Colors.purple;
      case 'orange': return Colors.orange;
      case 'pink': return Colors.pink;
      case 'black': return Colors.black;
      default: return Colors.white;
    }
  }

  // Helper to convert string alignment to TextAlign
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

  // Updated background decoration helper
  BoxDecoration? _getTextBackgroundDecoration(String? colorString, String? alignmentString) {
    if (colorString != null && colorString != 'null' && colorString != 'none') {
      return BoxDecoration(
        color: _stringToColor(colorString).withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      );
    }
    return null;
  }

  // Helper for background padding
  EdgeInsetsGeometry _getTextBackgroundPadding(String? alignmentString) {
    if (alignmentString != null && alignmentString != 'none') {
      return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
    }
    return EdgeInsets.zero;
  }

  void _updateParent() {
    final updatedTextProperties = widget.textElement.textPropertiesForStory.copyWith(
      fontSize: _currentFontSize,
    );
    final updatedElement = widget.textElement.copyWith(
      offset: _currentOffset,
      rotation: _currentRotation,
      textProperty: updatedTextProperties,
      // Size will be updated by the parent after layout, so we don't set it here
    );
    widget.onElementChanged(updatedElement);
  }

  @override
  Widget build(BuildContext context) {
    final textProps = widget.textElement.textPropertiesForStory;

    return Positioned(
      left: _currentOffset.dx,
      top: _currentOffset.dy,
      child: GestureDetector(
        onPanStart: (details) {
          _initialGestureOffset = _currentOffset;
        },
        onPanUpdate: (details) {
          setState(() {
            _currentOffset = _initialGestureOffset + details.delta;
            _updateParent();
          });
        },
        // onScaleStart: (details) {
        //   _initialGestureFontSize = _currentFontSize;
        //   _initialGestureRotation = _currentRotation;
        //   _initialGestureOffset = _currentOffset;
        // },
        // onScaleUpdate: (details) {
        //   setState(() {
        //     _currentFontSize = _initialGestureFontSize * details.scale;
        //     _currentRotation = _initialGestureRotation + details.rotation;
        //
        //     _currentOffset += details.focalPointDelta;
        //
        //     _updateParent();
        //   });
        // },
        child: Transform.translate(
          offset: Offset(widget.textElement.size!.width / 2, widget.textElement.size!.height / 2),
          child: Transform.rotate(
            angle: _currentRotation,
            child: Transform.scale(
              scale: _currentFontSize / 24.0,
              child: Transform.translate(
                offset: Offset(-widget.textElement.size!.width / 2, -widget.textElement.size!.height / 2),
                child: Container(
                  padding: _getTextBackgroundPadding(textProps.alignment),
                  child: Text(
                    widget.textElement.text ,
                    textAlign: _stringToTextAlign(textProps.alignment),
                    style: TextStyle(
                      color: textProps.color!,
                      fontSize: _currentFontSize,
                      fontWeight: _getFontWeight(textProps.bold),
                      fontStyle: _getFontStyle(textProps.italic),
                      decoration: _getTextDecoration(textProps.underline),
                      fontFamily: textProps.fontType,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
