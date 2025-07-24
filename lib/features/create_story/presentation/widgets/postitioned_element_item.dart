import 'package:easy_localization/easy_localization.dart';
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

  const PositionedElementItem({
    super.key,
    required this.positionedElement,
    required this.widgetKey,
  });

  @override
  State<PositionedElementItem> createState() => _PositionedElementItemState();
}

class _PositionedElementItemState extends State<PositionedElementItem> {
  Offset _position = Offset(100, 100);
  double _scale = 1.0;
  double _rotation = 0.0;
  Offset? _startFocalPoint;
  Offset? _startPosition;
  double? _startScale;
  double? _startRotation;
  late   PositionedElementStoryTheme _initStoryTheme ;

  @override
  void initState() {
    super.initState();
    _initStoryTheme = widget.positionedElement.positionedElementStoryTheme ??
        PositionedElementStoryTheme.white;
    _position = widget.positionedElement.offset ?? const Offset(100, 100);
    _scale = widget.positionedElement.scale ?? 1.0;
    _rotation = widget.positionedElement.rotation ?? 0.0;
  }

  int _pointerCount = 0;

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

      final updatedElement = widget.positionedElement.copyWith(
        offset: _position,
        rotation: _rotation,
        size: scaledSize,
        scale: _scale,
      );
      context.read<StoryEditorCubit>().updateSelectedPositioned(updatedElement);
      print(updatedElement.size);
    });
  }

  void _onScaleStart(ScaleStartDetails details) {
    _startFocalPoint = details.focalPoint;
    _startPosition = _position;
    _startScale = _scale;
    _startRotation = _rotation;
    setState(() {});
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    // If new finger added or removed, update base references
    setState(() {
      _position = _startPosition! + (details.focalPoint - _startFocalPoint!);

      // Scale with constraints
      _scale = (_startScale! * details.scale);

      // Rotation
      _rotation = _startRotation! + details.rotation;
    });
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
                    : Padding(
                      padding: const EdgeInsets.all(50),
                      child: MainPositionedWidget(
                        theme: _initStoryTheme,
                        onChangedTheme: () {
                          toggleElementTheme();
                          context
                              .read<StoryEditorCubit>()
                              .updateSelectedPositioned(
                                widget.positionedElement.copyWith(
                                  positionedElementStoryTheme: _initStoryTheme,
                                ),
                              );
                        },
                        key: widget.widgetKey,
                        child: _buildMainPostionedItem(context),
                      ),
                    ),
          ),
        ),
      ),
    );
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
    final svgColor =
        _initStoryTheme == PositionedElementStoryTheme.white
            ? null
            : _initStoryTheme ==
                PositionedElementStoryTheme.focusedWithPrimaryColor
            ? ColorManager.white
            : ColorManager.primaryColor;
    if (widget.positionedElement is PositionedMentionElement) {
      return Row(
        children: [
          SvgPicture.asset(AssetsManager.storyMention, color: svgColor),
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
          Text((widget.positionedElement as TemperatureElement).weatherCode),
        ],
      );
    } else if (widget.positionedElement is FeelingElement) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network((widget.positionedElement as FeelingElement).feelingIcon),
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
          SvgPicture.asset(AssetsManager.location, color: svgColor),
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
    } else if (widget.positionedElement is ClockElement) {
      return Row(
        children: [
          SvgPicture.asset(AssetsManager.storyClock, color: svgColor),
          Gaps.hGap1,
          Text(
            DateFormat('h:mm a')
                .format((widget.positionedElement as ClockElement).dateTime)
                .toLowerCase(),
            style: elementTextStyle,
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
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
