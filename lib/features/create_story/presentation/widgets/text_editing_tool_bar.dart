import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';

import '../../../../core/managers/app_gaps.dart' show Gaps;

class TextEditingToolbar extends StatelessWidget {
  final Color? currentColor;
  final String? currentFontTypeString;
  final bool? currentBold;
  final bool? currentItalic;
  final bool? currentUnderline;
  final String? currentAlignmentString;

  final Function(Color? color) onColorStringChanged;
  final Function(String? fontType) onFontTypeStringChanged;
  final Function(bool? bold) onBoldChanged;
  final Function(bool? italic) onItalicChanged;
  final Function(bool? underline) onUnderlineChanged;
  final Function(String? alignment) onAlignmentStringChanged;

  const TextEditingToolbar({
    Key? key,
    required this.currentColor,
    required this.currentFontTypeString,
    required this.currentBold,
    required this.currentItalic,
    required this.currentUnderline,
    required this.currentAlignmentString,
    required this.onColorStringChanged,
    required this.onFontTypeStringChanged,
    required this.onBoldChanged,
    required this.onItalicChanged,
    required this.onUnderlineChanged,
    required this.onAlignmentStringChanged,
  }) : super(key: key);

  final List<String> availableFonts = const [
    'Roboto',
    'OpenSans',
    'Lato',
    'Montserrat',
    // Add more fonts as needed
  ];


  // Helper to get alignment icon
  IconData _getAlignmentIcon(String? alignString) {
    switch (alignString?.toLowerCase()) {
      case 'left':
        return Icons.format_align_left;
      case 'center':
        return Icons.format_align_center;
      case 'right':
        return Icons.format_align_right;
      default:
        return Icons.format_align_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Vertical Toolbar on the left
        Positioned(
          left: 16,
          top: MediaQuery
              .of(context)
              .padding
              .top + 60, // Adjust top to be below top toolbar
          bottom: MediaQuery
              .of(context)
              .padding
              .bottom + 120, // Adjust bottom to be above bottom toolbar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Bold Toggle
              _buildTextToolbarButton(
                assets: AssetsManager.textBold,
                isActive: currentBold ?? false,
                onTap: () => onBoldChanged(!(currentBold ?? false)),
              ),
              Gaps.vGap2,
              _buildTextToolbarButton(
                assets: AssetsManager.textItalic,
                isActive: currentItalic ?? false,
                onTap: () => onItalicChanged(!(currentItalic ?? false)),
              ),
              Gaps.vGap2,
              _buildTextToolbarButton(
                assets: AssetsManager.textUnderLine,
                isActive: currentUnderline ?? false,
                onTap: () => onUnderlineChanged(!(currentUnderline ?? false)),
              ),
              Gaps.vGap2,
              InkWell(
                onTap: () {
                  final nextAlignment = currentAlignmentString == 'left'
                      ? 'center'
                      : currentAlignmentString == 'center'
                      ? 'right'
                      : 'left';
                  onAlignmentStringChanged(nextAlignment);
                },
                child: Icon(_getAlignmentIcon(currentAlignmentString)),
              ),
              Gaps.vGap2,
              InkWell(
                onTap: () {
                  final currentIndex = availableFonts.indexOf(
                      currentFontTypeString ?? 'Roboto');
                  final nextIndex = (currentIndex + 1) % availableFonts.length;
                  onFontTypeStringChanged(availableFonts[nextIndex]);
                },
                child: Icon( Icons.font_download),
              ),

              Gaps.vGap2,
              InkWell(
                onTap: (){},
                child: SvgPicture.asset(AssetsManager.colorPallete),
              )


            ],
          ),
        ),

        // Horizontal Color Palette and Font Selector (at the bottom)
        Positioned(
          bottom: MediaQuery
              .of(context)
              .padding
              .bottom + 16, // Adjust position
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Color Palette
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                  [
                    Colors.red,
                    Colors.blue,
                    Colors.green,
                    Colors.yellow,
                    Colors.purple,
                    Colors.orange,
                    Colors.pink,
                    Colors.white,
                    Colors.black,
                  ]
                      .map(
                        (color) =>
                        GestureDetector(
                          onTap: () {
                            onColorStringChanged(color);
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: currentColor == color
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                  )
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),

              // Font Selector (horizontal list of font names)
              SizedBox(
                height: 40, // Height for font names
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: availableFonts.map((fontFamily) {
                    return GestureDetector(
                      onTap: () => onFontTypeStringChanged(fontFamily),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: currentFontTypeString == fontFamily
                              ? Colors.white.withOpacity(0.8)
                              : Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            fontFamily,
                            style: TextStyle(
                              color: currentFontTypeString == fontFamily
                                  ? Colors.black
                                  : Colors.white,
                              fontFamily: fontFamily,
                              // Apply the font family to its own name
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper for text toolbar buttons
  Widget _buildTextToolbarButton({
    required String assets,
    required Function() onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isActive ? ColorManager.primaryColor : ColorManager
              .primaryColor.withOpacity(0.3),
        ),
        child: SvgPicture.asset(assets, color: isActive ? Colors.white : null,),
      ),
    );
  }
}
