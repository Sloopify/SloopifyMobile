import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
class EditableTextElement extends StatefulWidget {
  final PositionedTextElement textElement;
  final GlobalKey widgetKey;
  final Function(PositionedTextElement updatedElement) onElementChanged;

  const EditableTextElement({
    Key? key,
    required this.textElement,
    required this.onElementChanged,
    required this.widgetKey
  }) : super(key: key);

  @override
  State<EditableTextElement> createState() => _EditableTextElementState();
}

class _EditableTextElementState extends State<EditableTextElement> {
  Offset _position = Offset(100, 100);
  double _scale = 1.0;
  double _initialScale = 1.0;
  double _rotation = 0.0;
  double _initialRotation = 0.0;
  Offset _initialFocalPoint = Offset.zero;
  Offset _initialPosition = Offset.zero;
  double _initialFontSize=24;
  double _currentFontSize=24;
  int _pointerCount = 0;

  @override
  void initState() {
    super.initState();
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



  void _updateParent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size? originalSize = widget.widgetKey.currentContext?.size;
      Size scaledSize=Size.zero;
      if (originalSize != null) {
        Size scaledSize = Size(
          originalSize.width * _scale,
          originalSize.height * _scale,
        );
        print("Scaled Size: $scaledSize");
      }
        // Fallback if context is not available (should be rare after addPostFrameCallback)
        final updatedTextProperties = widget.textElement.textPropertiesForStory.copyWith(
          fontSize: _currentFontSize
        );
        final updatedElement = widget.textElement.copyWith(
          offset: _position,
          rotation: _rotation,
          textProperty: updatedTextProperties,
          size: scaledSize,
          scale: _scale,
        );
        widget.onElementChanged(updatedElement);

    });
  }

  void _onScaleStart(ScaleStartDetails details) {
    print('nnnnnnnnnnnnnnnnnnn');
    _initialScale = _scale;
    _initialRotation = _rotation;
    _initialFocalPoint = details.focalPoint;
    _initialPosition = _position;
    _initialFontSize=_currentFontSize;


  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    // If new finger added or removed, update base references

    setState(() {
      _scale = (_initialScale * details.scale).clamp(0.5, 5.0);
      _rotation = _initialRotation + details.rotation;
      final delta = details.focalPoint - _initialFocalPoint;
      _position = _initialPosition + delta;
    });
    print('nnnnnnnnnnnnnnnnnnn');
    print(_pointerCount);
    _updateParent();


  }



  @override
  Widget build(BuildContext context) {
    final textProps = widget.textElement.textPropertiesForStory;

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        child: Transform(
          transform: Matrix4.identity()
            ..translate(0.0, 0.0)
            ..rotateZ(_rotation)
            ..scale(_scale),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.transparent,
            child:  Text(
              key: widget.widgetKey,
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

        );

  }
}
