import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gif_view/gif_view.dart';
import 'package:lottie/lottie.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/utils/helper/postioned_element_story_theme.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/gif_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/main_postitioned_widget.dart';

import '../../../../core/ui/widgets/general_image.dart';

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
  PositionedElementStoryTheme _initStoryTheme =
      PositionedElementStoryTheme.white;

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
        positionedElementStoryTheme: _initStoryTheme,
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
        child: Transform.translate(
        offset: Offset.zero,
        child: Transform.rotate(
        angle: _rotation,
        child: Transform.scale(
        scale: _scale,
          child:
          widget.positionedElement is StickerElement
              ? GifView.network(
            (widget.positionedElement as StickerElement).gifUrl,
            height: 200,
            width: 200,
          )
              : MainPositionedWidget(
            theme: _initStoryTheme,
            onChangedTheme: () {
              toggleElementTheme();
              context.read<StoryEditorCubit>().togglePositionedTheme(
                _initStoryTheme,
              );
            },
            key: widget.widgetKey,
            child: _buildMainPostionedItem(context),
          ),
        ),
      ),
    )));
  }

  Widget _buildMainPostionedItem(BuildContext context) {
    final elementTextStyle = AppTheme.headline4.copyWith(
      fontWeight: FontWeight.w500,
      color:
          _initStoryTheme == PositionedElementStoryTheme.white
              ? ColorManager.black
              : _initStoryTheme ==
                  PositionedElementStoryTheme.focusedWithPrimaryColor
              ? ColorManager.white
              : ColorManager.primaryColor,
    );
    if (widget.positionedElement is PositionedMentionElement) {
      return Row(
        children: [
          SvgPicture.asset(
            AssetsManager.storyMention,
            color:
                _initStoryTheme == PositionedElementStoryTheme.white
                    ? null
                    : ColorManager.primaryColor,
          ),
          Gaps.hGap1,
          Text(
            (widget.positionedElement as PositionedMentionElement).friendName,
            style: elementTextStyle,
          ),
        ],
      );
    } else if (widget.positionedElement is TemperatureElement) {
      return Row(
        children: [
          Text(
            (widget.positionedElement as TemperatureElement).value
                .toStringAsFixed(0),
            style: elementTextStyle,
          ),
          Text(
            getWeatherEmoji(
              (widget.positionedElement as TemperatureElement).value,
            ),
          ),
        ],
      );
    } else if (widget.positionedElement is FeelingElement) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GeneralImage.circular(
            radius: 35,
            isNetworkImage: true,
            placeHolder: Icon(Icons.emoji_emotions),
            image: (widget.positionedElement as FeelingElement).feelingIcon,
          ),
          Gaps.hGap1,
          Text(
            (widget.positionedElement as FeelingElement).feelingName,
            style: elementTextStyle,
          ),
        ],
      );
    } else if (widget.positionedElement is PositionedElementWithLocationId) {
      return Row(
        children: [
          SvgPicture.asset(AssetsManager.location),
          Gaps.hGap1,
          Text(
            '${(widget.positionedElement as PositionedElementWithLocationId).countryName}, ${(widget.positionedElement as PositionedElementWithLocationId).cityName}',
            style: elementTextStyle,
          ),
        ],
      );
    } else if (widget.positionedElement is AudioElement) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: GeneralImage.circular(
                  radius: 30,
                  isNetworkImage: true,
                  placeHolder: SvgPicture.asset(AssetsManager.logo),
                  image: (widget.positionedElement as AudioElement).audioImage,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Lottie.asset(
                  AssetsManager.audioPlaying,
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
            ],
          ),
          Gaps.hGap1,
          Text(
            (widget.positionedElement as AudioElement).audioName,
            style: elementTextStyle,
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }

  String getWeatherEmoji(double tempCelsius) {
    if (tempCelsius >= 35) return '🔥'; // Very hot
    if (tempCelsius >= 25) return '☀️'; // Warm
    if (tempCelsius >= 15) return '🌤'; // Mild
    if (tempCelsius >= 5) return '🌥'; // Cool
    if (tempCelsius >= 0) return '❄️'; // Cold
    return '🥶'; // Freezing
  }

  void toggleElementTheme() {
    if (_initStoryTheme == PositionedElementStoryTheme.white) {
      setState(() {
        _initStoryTheme = PositionedElementStoryTheme.normalWithBorder;
      });
    } else if (_initStoryTheme ==
        PositionedElementStoryTheme.normalWithBorder) {
      setState(() {
        _initStoryTheme = PositionedElementStoryTheme.focusedWithPrimaryColor;
      });
    } else if (_initStoryTheme ==
        PositionedElementStoryTheme.focusedWithPrimaryColor) {
      setState(() {
        _initStoryTheme = PositionedElementStoryTheme.focusedWithPrimaryShade;
      });
    } else if (_initStoryTheme ==
        PositionedElementStoryTheme.focusedWithPrimaryShade) {
      setState(() {
        _initStoryTheme = PositionedElementStoryTheme.white;
      });
    }
  }
}
