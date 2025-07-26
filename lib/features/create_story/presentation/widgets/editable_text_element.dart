import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';

class EditableTextElement extends StatefulWidget {
  final PositionedTextElement textElement;
  final GlobalKey widgetKey;
  final VoidCallback? onTap;
  final VoidCallback onScale;
  final VoidCallback onDelete;

  const EditableTextElement({
    Key? key,
    required this.textElement,
    required this.widgetKey,
    this.onTap,
    required this.onScale,
    required this.onDelete,
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

  // Delete tracking
  bool _showTrash = false;
  double _trashScale = 0.0;

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
    widget.onScale();
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final screenHeight = MediaQuery.of(context).size.height;
    final trashZoneHeight = screenHeight * 0.1;
    final trashZoneTop = screenHeight - trashZoneHeight;

    setState(() {
      // Update position
      _position = _startPosition! + (details.focalPoint - _startFocalPoint!);
      _scale = (_startScale! * details.scale);
      _rotation = _startRotation! + details.rotation;
      // Check if in trash zone
      final inTrashZone = details.focalPoint.dy > trashZoneTop;
      _showTrash = inTrashZone;

      // Calculate trash icon scale
      if (inTrashZone) {
        final progress =
            (details.focalPoint.dy - trashZoneTop) / trashZoneHeight;
        _trashScale = progress.clamp(0.0, 1.0);
      } else {
        _trashScale = 0.0;

      }
    });

    final updated = widget.textElement.copyWith(
      offset: _position,
      scale: _scale,
      rotation: _rotation,
    );
    context.read<TextEditingCubit>().updateSelectedPositionedText(updated);
  }

  void _animateDelete() async {
    // Shrink animation
    for (double s = _scale; s > 0.5; s -= 0.1) {
      await Future.delayed(Duration(milliseconds: 30));
      if (mounted) setState(() => _scale = s);
    }

    // Trigger delete
    widget.onDelete();
  }

  @override
  Widget build(BuildContext context) {
    final textProps = widget.textElement.textPropertiesForStory;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // The trash zone (positioned at screen bottom)
        Positioned(
          bottom: 0,
          left: MediaQuery.of(context).size.width * 0.2,
          right: MediaQuery.of(context).size.width * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(100)),
            child: Center(
              child: AnimatedScale(
                scale: _trashScale,
                duration: Duration(milliseconds: 200),
                child: SvgPicture.asset(AssetsManager.deleteItem)
              ),
            ),
          ),
        ),

        // The text element
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: widget.onTap,
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            onScaleEnd: (_) {
              if (_showTrash) {
                _animateDelete();
              }
              setState(() {
                _showTrash = false;
                _trashScale = 0.0;
              });
            },
            child: Transform.rotate(
              angle: _rotation,
              child: Transform.scale(
                scale: _scale,
                child: Container(
                  key: widget.key,
                  color: Colors.transparent,
                  padding: EdgeInsets.all(50),
                  child: Text(
                    widget.textElement.text,
                    style: TextStyle(
                      color:
                          _showTrash
                              ? Colors.grey
                              : textProps.color ?? Colors.black,
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
        ),
      ],
    );
  }
}
