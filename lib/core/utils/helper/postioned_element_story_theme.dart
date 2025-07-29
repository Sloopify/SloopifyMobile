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
extension PostionedElementStoryExtensionString on String {
  PositionedElementStoryTheme getValuesFromApi() {
    switch (this) {
      case "theme_1":
        return PositionedElementStoryTheme.white;
      case "theme_2":
        return  PositionedElementStoryTheme.normalWithBorder;
      case "theme_3" :
        return PositionedElementStoryTheme.focusedWithPrimaryColor;
      case "theme_4":
        return PositionedElementStoryTheme.focusedWithPrimaryShade ;
      default:
        return PositionedElementStoryTheme.white;
    }
  }
}