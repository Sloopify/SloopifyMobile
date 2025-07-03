enum PositionedElementStoryTheme {
  white,
  normalWithBorder,
  focusedWithPrimaryColor,
  focusedWithPrimaryShade,
}

extension PostionedElementStoryExtension on PositionedElementStoryTheme {
  String getValuesForApi() {
    switch (this) {
      case PositionedElementStoryTheme.white:
        return "theme_1";
      case PositionedElementStoryTheme.normalWithBorder:
        return "theme_2";
      case PositionedElementStoryTheme.focusedWithPrimaryColor:
        return "theme_3";
      case PositionedElementStoryTheme.focusedWithPrimaryShade:
        return "theme_4";
    }
  }
}
