import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';

class EditableTextElement extends StatefulWidget {
  final PositionedTextElement textElement;
  final GlobalKey widgetKey;
  final Function()? onTap;
  final Function(PositionedTextElement updatedElement) onElementChanged;

  const EditableTextElement({
    Key? key,
    required this.textElement,
    required this.onElementChanged,
    required this.widgetKey,
    this.onTap,
  }) : super(key: key);

  @override
  State<EditableTextElement> createState() => _EditableTextElementState();
}

class _EditableTextElementState extends State<EditableTextElement> {
  late Offset _offset;
  late double _scale;
  late double _rotation;

  late Offset _initialOffset;
  late Offset _startFocalPoint;
  late double _initialScale;
  late double _initialRotation;

  @override
  void initState() {
    super.initState();
    _offset = widget.textElement.offset ?? const Offset(0, 0);
    _scale = widget.textElement.scale ?? 1.0;
    _rotation = widget.textElement.rotation ?? 0.0;
  }

  @override
  void didUpdateWidget(covariant EditableTextElement oldWidget) {
    super.didUpdateWidget(oldWidget);
    _offset = widget.textElement.offset ?? _offset;
    _scale = widget.textElement.scale ?? _scale;
    _rotation = widget.textElement.rotation ?? _rotation;
  }

  double _initialFontSize = 24;
  double _currentFontSize = 24;
  int _pointerCount = 0;

  // Helper to convert string alignment to TextAlign
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

  void _updateParent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size? originalSize = widget.widgetKey.currentContext?.size;
      Size scaledSize = Size.zero;
      if (originalSize != null) {
        Size scaledSize = Size(
          originalSize.width * _scale,
          originalSize.height * _scale,
        );
        print("Scaled Size: $scaledSize");
      }
      // Fallback if context is not available (should be rare after addPostFrameCallback)
      final updatedTextProperties = widget.textElement.textPropertiesForStory
          .copyWith(fontSize: _currentFontSize);
      final updatedElement = widget.textElement.copyWith(
        offset: _offset,
        rotation: _rotation,
        textProperty: updatedTextProperties,
        size: scaledSize,
        scale: _scale,
      );
      context.read<TextEditingCubit>().updateSelectedPositionedText(
        updatedElement,
      );
    });
  }

  void _onScaleStart(ScaleStartDetails details) {
    print('nnnnnnnnnnnnnnnnnnn');
    _initialScale = _scale;
    _initialRotation = _rotation;
    _startFocalPoint = details.focalPoint;
    _startFocalPoint = details.focalPoint;
    _initialOffset = details.focalPoint;
    _initialFontSize = _currentFontSize;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    // If new finger added or removed, update base references

    setState(() {
      _scale = (_initialScale * details.scale).clamp(0.5, 5.0);
      _rotation = _initialRotation + details.rotation;
      final delta = details.focalPoint - _startFocalPoint;
      _offset = _initialOffset + delta;
    });
    print('nnnnnnnnnnnnnnnnnnn');
    print(_pointerCount);
  }

  @override
  Widget build(BuildContext context) {
    print(_offset);
    final textProps = widget.textElement.textPropertiesForStory;
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: GestureDetector(
        onTap: widget.onTap,
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: (_) {
          _updateParent();
        },
        child: Transform(
          transform:
              Matrix4.identity()
                ..rotateZ(_rotation)
                ..scale(_scale)
                ..translate(-(MediaQuery.of(context).size.width*0.8)/2, 0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.transparent,
            child: Text(
              key: widget.widgetKey,
              widget.textElement.text,
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
