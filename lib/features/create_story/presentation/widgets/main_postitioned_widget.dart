import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/utils/helper/postioned_element_story_theme.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';

class MainPositionedWidget extends StatefulWidget {
  final Widget child;
  final Function () onChangedTheme;
  final PositionedElementStoryTheme theme;

  const MainPositionedWidget({
    super.key,
    required this.child,
    required this.onChangedTheme,
    required this.theme
  });

  @override
  State<MainPositionedWidget> createState() => _MainPositionedWidgetState();
}

class _MainPositionedWidgetState extends State<MainPositionedWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onChangedTheme,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p10,
          vertical: AppPadding.p8,
        ),
        decoration: BoxDecoration(
          color: getElementColorDependsOnTheme(widget.theme),
          border: Border.all(
              color: getBorderColorDependsOnTheme(widget.theme)),
          borderRadius: BorderRadius.circular(10),
          boxShadow:
          widget.theme == PositionedElementStoryTheme.normalWithBorder
              ? null
              : [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }

  Color getElementColorDependsOnTheme(PositionedElementStoryTheme theme) {
    switch (theme) {
      case PositionedElementStoryTheme.white:
        return ColorManager.white;
      case PositionedElementStoryTheme.normalWithBorder:
        return Colors.transparent;
      case PositionedElementStoryTheme.focusedWithPrimaryColor:
        return ColorManager.primaryColor;
      case PositionedElementStoryTheme.focusedWithPrimaryShade:
        return ColorManager.primaryShade4.withOpacity(0.25);
    }
  }

  Color getBorderColorDependsOnTheme(PositionedElementStoryTheme theme) {
    switch (theme) {
      case PositionedElementStoryTheme.white:
        return ColorManager.white;
      case PositionedElementStoryTheme.normalWithBorder:
        return ColorManager.primaryColor;
      case PositionedElementStoryTheme.focusedWithPrimaryColor:
        return ColorManager.primaryColor;
      case PositionedElementStoryTheme.focusedWithPrimaryShade:
        return ColorManager.primaryShade4;
    }
  }

  Color getTextColor(PositionedElementStoryTheme theme) {
    switch (theme) {
      case PositionedElementStoryTheme.white:
        return ColorManager.black;
      case PositionedElementStoryTheme.normalWithBorder:
        return ColorManager.primaryColor;
      case PositionedElementStoryTheme.focusedWithPrimaryColor:
        return ColorManager.white;
      case PositionedElementStoryTheme.focusedWithPrimaryShade:
        return ColorManager.white;
    }
  }


}
