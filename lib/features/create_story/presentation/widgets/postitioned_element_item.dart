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
import 'package:sloopify_mobile/features/create_story/domain/entities/poll_entity_option.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/gif_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/main_postitioned_widget.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/poll_widget.dart';

import '../../../../core/ui/widgets/general_image.dart';

class PositionedElementItem extends StatefulWidget {
  final PositionedElement positionedElement;
  final GlobalKey widgetKey;
  final VoidCallback onDelete;
  final VoidCallback onScale;

  const PositionedElementItem({
    super.key,
    required this.positionedElement,
    required this.widgetKey,
    required this.onDelete,
    required this.onScale,
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
  late PositionedElementStoryTheme _initStoryTheme;

  // Delete tracking
  bool _showTrash = false;
  double _trashScale = 0.0;

  @override
  void initState() {
    super.initState();
    _initStoryTheme =
        widget.positionedElement.positionedElementStoryTheme ??
        PositionedElementStoryTheme.white;
    _position = widget.positionedElement.offset ?? const Offset(100, 100);
    _scale = widget.positionedElement.scale ?? 1.0;
    _rotation = widget.positionedElement.rotation ?? 0.0;
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

      final updatedElement = widget.positionedElement.copyWith(
        offset: _position,
        rotation: _rotation,
        size: scaledSize,
        scale: _scale,
      );
      if (mounted) {
        context.read<StoryEditorCubit>().updateSelectedPositioned(
          updatedElement,
        );
      }
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
    final screenHeight = MediaQuery.of(context).size.height;
    final trashZoneHeight = screenHeight * 0.1;
    final trashZoneTop = screenHeight - trashZoneHeight;
    // If new finger added or removed, update base references
    setState(() {
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
    widget.onScale();
    _updateParent();
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
                child: SvgPicture.asset(AssetsManager.deleteItem),
              ),
            ),
          ),
        ),
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
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
                child:
                    widget.positionedElement is PollElement
                        ? PollCreationWidget()
                        : widget.positionedElement is StickerElement
                        ? GifView.network(
                          (widget.positionedElement as StickerElement).gifUrl,
                          height: 200,
                          width: 200,
                        )
                        : Container(
                          padding: EdgeInsets.all(50),
                          color: Colors.transparent,
                          child: MainPositionedWidget(
                            theme: _initStoryTheme,
                            onChangedTheme: () {
                              toggleElementTheme();
                              context
                                  .read<StoryEditorCubit>()
                                  .updateSelectedPositioned(
                                    widget.positionedElement.copyWith(
                                      positionedElementStoryTheme:
                                          _initStoryTheme,
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
        ),
      ],
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
      print((widget.positionedElement as TemperatureElement).weatherCode);
      return Row(
        children: [
          Text(
           '${ (widget.positionedElement as TemperatureElement).value
               .toStringAsFixed(0)}°',
            style: elementTextStyle,
          ),
           Text(getWeatherSticker(  (widget.positionedElement as TemperatureElement))),
        ],
      );
    } else if (widget.positionedElement is FeelingElement) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.network(
            (widget.positionedElement as FeelingElement).feelingIcon,
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
  String getWeatherSticker(TemperatureElement temp) {
    // Define weather condition category
    final isRain = temp.weatherCode >= 200 && temp.weatherCode < 600;
    final isSnow = temp.weatherCode >= 600 && temp.weatherCode < 700;
    final isCloudy = temp.weatherCode > 800;
    final isClear = temp.weatherCode == 800;

    // 🌙 or ☀️ based on time
    final timeEmoji = temp.isDay ? '☀️' : '🌙';

    // 🌧️ if raining
    if (isRain) {
      if (temp.value >= 20 && temp.isDay) return '🌦️'; // sun + rain
      if (temp.value >= 20 ) return '🌧️🌙'; // night rain
      return temp.isDay ? '🌧️' : '🌧️🌙';
    }

    // ❄️ if snowing
    if (isSnow) return '❄️$timeEmoji';

    // ☁️ if cloudy
    if (isCloudy) {
      if (temp.value < 15) return '☁️❄️$timeEmoji'; // cold cloudy
      return '☁️$timeEmoji';
    }

    // ☀️ or 🌙 for clear
    if (isClear) {
      if (temp.value >= 25 && temp.isDay) return '🔥☀️'; // hot sunny
      if (temp.value <= 5 && temp.isDay) return '❄️☀️';
      if (temp.value <= 5 && !temp.isDay) return '❄️🌙';
      return timeEmoji;
    }

    return timeEmoji; // fallback
  }
}
