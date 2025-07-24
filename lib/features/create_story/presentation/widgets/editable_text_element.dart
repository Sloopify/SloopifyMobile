import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';

class EditableTextElement extends StatefulWidget {
  final PositionedTextElement textElement;
  final GlobalKey widgetKey;
  final VoidCallback? onTap;
  final VoidCallback onScale;

  const EditableTextElement({
    Key? key,
    required this.textElement,
    required this.widgetKey,
    this.onTap,
    required this.onScale,
  }) : super(key: key);

  @override
  State<EditableTextElement> createState() => _EditableTextElementState();
}

class _EditableTextElementState extends State<EditableTextElement> {
  Offset _position = Offset(100, 100);
  double _scale = 1.0;
  double _rotation = 0.0;
  Offset? _startFocalPoint;
  Offset? _startPosition;
  double? _startScale;
  double? _startRotation;

  @override
  void initState() {
    super.initState();
    _position = widget.textElement.offset ?? Offset.zero;
    _scale = widget.textElement.scale ?? 1.0;
    _rotation = widget.textElement.rotation ?? 0.0;
  }

  void _onScaleStart(ScaleStartDetails details) {
    _startFocalPoint = details.focalPoint;
    _startPosition = _position;
    _startScale = _scale;
    _startRotation = _rotation;
    setState(() {});
    widget.onScale();
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _position = _startPosition! + (details.focalPoint - _startFocalPoint!);

      // Scale with constraints
      _scale = (_startScale! * details.scale);

      // Rotation
      _rotation = _startRotation! + details.rotation;
    });

    final updated = widget.textElement.copyWith(
      offset: _position,
      scale: _scale,
      rotation: _rotation,
    );

    context.read<TextEditingCubit>().updateSelectedPositionedText(updated);
  }

  @override
  Widget build(BuildContext context) {
    final textProps = widget.textElement.textPropertiesForStory;
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.onTap,
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,

        child: Transform.rotate(
          angle: _rotation,
          child: Transform.scale(
            scale: _scale,
            child: Container(
              padding: EdgeInsets.all(50),
              key: widget.widgetKey,
              color: Colors.transparent,
              child: Text(
                widget.textElement.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textProps.color ?? Colors.black,
                  fontSize: textProps.fontSize ?? 24,
                  fontWeight:
                      textProps.bold == true
                          ? FontWeight.bold
                          : FontWeight.normal,
                  fontStyle:
                      textProps.italic == true
                          ? FontStyle.italic
                          : FontStyle.normal,
                  decoration:
                      textProps.underline == true
                          ? TextDecoration.underline
                          : TextDecoration.none,
                  fontFamily: textProps.fontType,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
