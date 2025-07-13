import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/utils/helper/postioned_element_story_theme.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/main_postitioned_widget.dart';

class PositionedElementItem extends StatefulWidget {
  final PositionedElement positionedElement;
  final GlobalKey widgetKey;
  final Function(PositionedElement element) onUpdateElement;

  const PositionedElementItem({
    super.key,
    required this.positionedElement,
    required this.widgetKey,
    required this.onUpdateElement,
  });

  @override
  State<PositionedElementItem> createState() => _PositionedElementItemState();
}

class _PositionedElementItemState extends State<PositionedElementItem> {
  Offset _position = Offset(100, 100);
  double _scale = 1.0;
  double _initialScale = 1.0;
  double _rotation = 0.0;
  double _initialRotation = 0.0;
  Offset _initialFocalPoint = Offset.zero;
  Offset _initialPosition = Offset.zero;
  double _initialFontSize = 24;
  double _currentFontSize = 24;
  int _pointerCount = 0;

  void _updateParent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size? originalSize = widget.widgetKey.currentContext?.size;
      print('ooooooooo${originalSize}');
      Size scaledSize = Size.zero;
      if (originalSize != null) {
        Size scaledSize = Size(
          originalSize.width * _scale,
          originalSize.height * _scale,
        );
        print("Scaled Size: $scaledSize");
      }

      final updatedElement = widget.positionedElement.copyWith(
        offset: _position,
        rotation: _rotation,
        size: scaledSize,
        scale: _scale,
      );
      print(updatedElement.size);
      widget.onUpdateElement(updatedElement);
    });
  }

  void _onScaleStart(ScaleStartDetails details) {
    _initialScale = _scale;
    _initialRotation = _rotation;
    _initialFocalPoint = details.focalPoint;
    _initialPosition = _position;
    _initialFontSize = _currentFontSize;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    // If new finger added or removed, update base references

    setState(() {
      _scale = (_initialScale * details.scale).clamp(0.5, 5.0);
      _rotation = _initialRotation + details.rotation;
      final delta = details.focalPoint - _initialFocalPoint;
      _position = _initialPosition + delta;
    });
    print(_pointerCount);
    _updateParent();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        child: Transform(
          transform:
              Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(_rotation)
                ..scale(_scale),
          child: MainPositionedWidget(
            key: widget.widgetKey,
            theme: widget.positionedElement.positionedElementStoryTheme!,
            child: _buildMainPostionedItem(context),
          ),
        ),
      ),
    );
  }

  Widget _buildMainPostionedItem(BuildContext context) {
    if (widget.positionedElement is PositionedMentionElement) {
      return Row(
        children: [
          SvgPicture.asset(
            AssetsManager.storyMention,
            color:
                widget.positionedElement.positionedElementStoryTheme ==
                        PositionedElementStoryTheme.white
                    ? null
                    : ColorManager.primaryColor,
          ),
          Gaps.hGap1,
          Text(
            (widget.positionedElement as PositionedMentionElement).friendName,
            style: AppTheme.headline4.copyWith(
              fontWeight: FontWeight.w500,
              color:
                  widget.positionedElement.positionedElementStoryTheme ==
                          PositionedElementStoryTheme.white
                      ? ColorManager.black
                      : widget.positionedElement.positionedElementStoryTheme ==
                          PositionedElementStoryTheme.focusedWithPrimaryColor
                      ? ColorManager.white
                      : ColorManager.primaryColor,
            ),
          ),
        ],
      );
    } else if (widget.positionedElement is TemperatureElement) {
      return Row(
        children: [
          Text(
            (widget.positionedElement as TemperatureElement).value
                .toStringAsFixed(0),
            style: AppTheme.headline4.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorManager.white,
            ),
          ),
          Text(getWeatherEmoji( (widget.positionedElement as TemperatureElement).value))
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  String getWeatherEmoji(double tempCelsius) {
    if (tempCelsius >= 35) return '🔥'; // Very hot
    if (tempCelsius >= 25) return '☀️'; // Warm
    if (tempCelsius >= 15) return '🌤'; // Mild
    if (tempCelsius >= 5) return '🌥'; // Cool
    if (tempCelsius >= 0) return '❄️'; // Cold
    return '🥶'; // Freezing
  }
}
