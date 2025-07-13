import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/utils/helper/postioned_element_story_theme.dart';

class MainPositionedWidget extends StatefulWidget {
  final Widget child;
  final PositionedElementStoryTheme theme;

  const MainPositionedWidget({
    super.key,
    required this.child,
    required this.theme,
  });

  @override
  State<MainPositionedWidget> createState() => _MainPositionedWidgetState();
}

class _MainPositionedWidgetState extends State<MainPositionedWidget> {
   PositionedElementStoryTheme currentTheme=PositionedElementStoryTheme.white;

  @override
  void initState() {
   currentTheme==widget.theme;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleElementTheme,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p10,
          vertical: AppPadding.p8,
        ),
        decoration: BoxDecoration(
          color: getElementColorDependsOnTheme(currentTheme),
          border: Border.all(color: getBorderColorDependsOnTheme(currentTheme)),
          borderRadius: BorderRadius.circular(10),
          boxShadow:
          currentTheme == PositionedElementStoryTheme.normalWithBorder
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
        return ColorManager.primaryShade4;
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

  void toggleElementTheme(){
    if(currentTheme==PositionedElementStoryTheme.white){
      setState(() {
        currentTheme=PositionedElementStoryTheme.normalWithBorder;
      });

    }else if (currentTheme==PositionedElementStoryTheme.normalWithBorder){
      setState(() {
        currentTheme=PositionedElementStoryTheme.focusedWithPrimaryColor;

      });
    }else if(currentTheme==PositionedElementStoryTheme.focusedWithPrimaryColor){
      setState(() {
        currentTheme=PositionedElementStoryTheme.focusedWithPrimaryShade;

      });

    }else if (currentTheme==PositionedElementStoryTheme.focusedWithPrimaryShade){
      setState(() {
        currentTheme=PositionedElementStoryTheme.white;

      });
    }
  }
}
