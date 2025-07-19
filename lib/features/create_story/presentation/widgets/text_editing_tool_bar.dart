import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_fonts.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_state.dart';

import '../../../../core/managers/app_gaps.dart' show Gaps;

class TextEditingToolbar extends StatefulWidget {
  TextEditingToolbar({Key? key}) : super(key: key);

  @override
  State<TextEditingToolbar> createState() => _TextEditingToolbarState();
}

class _TextEditingToolbarState extends State<TextEditingToolbar> {
  final List<String> availableFonts = AppFonts.availableFonts;
  bool isColorActive=false;
  bool isFontsActive=false;


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
    return BlocBuilder<TextEditingCubit, TextEditingState>(
      builder: (context, state) {
        return Stack(
          children: [
            // Vertical Toolbar on the left
            Positioned(
              left: 16,
              top:
                  MediaQuery.of(context).padding.top +
                  100, // Adjust top to be below top toolbar
              bottom:
                  MediaQuery.of(context).padding.bottom +
                  120, // Adjust bottom to be above bottom toolbar
              child: Column(
                children: [
                  // Bold Toggle
                  _buildTextToolbarButton(
                    assets: AssetsManager.textBold,
                    isActive: state.textPropertiesForStory.bold ?? false,
                    onTap:
                        () =>
                            context
                                .read<TextEditingCubit>()
                                .toggleCurrentTextBold(),
                  ),
                  Gaps.vGap2,
                  _buildTextToolbarButton(
                    assets: AssetsManager.textItalic,
                    isActive: state.textPropertiesForStory.italic ?? false,
                    onTap:
                        () =>
                            context
                                .read<TextEditingCubit>()
                                .toggleCurrentTextItalic(),
                  ),
                  Gaps.vGap2,
                  _buildTextToolbarButton(
                    assets: AssetsManager.textUnderLine,
                    isActive: state.textPropertiesForStory.underline ?? false,
                    onTap:
                        () =>
                            context
                                .read<TextEditingCubit>()
                                .toggleCurrentTextUnderline(),
                  ),
                  Gaps.vGap2,
                  InkWell(
                    onTap: () {
                      final nextAlignment =
                          state.textPropertiesForStory.alignment == 'left'
                              ? 'center'
                              : state.textPropertiesForStory.alignment ==
                                  'center'
                              ? 'right'
                              : 'left';
                      context
                          .read<TextEditingCubit>()
                          .changeCurrentTextAlignmentString(nextAlignment);
                    },
                    child: Icon(
                      _getAlignmentIcon(state.textPropertiesForStory.alignment),
                    ),
                  ),
                  Gaps.vGap2,
                  InkWell(
                    onTap: () {
                      setState(() {
                        isFontsActive=true;
                        isColorActive=false;
                      });
                      final currentIndex = availableFonts.indexOf(
                        state.textPropertiesForStory.fontType ?? 'Roboto',
                      );
                      final nextIndex =
                          (currentIndex + 1) % availableFonts.length;
                      context.read<TextEditingCubit>().changeCurrentFontType(
                        availableFonts[nextIndex],
                      );
                    },
                    child: Icon(Icons.font_download),
                  ),

                  Gaps.vGap2,
                  InkWell(
                    onTap: () {
                      setState(() {
                        isColorActive=true;
                        isFontsActive=false;
                      });
                    },
                    child: SvgPicture.asset(AssetsManager.colorPallete),
                  ),
                ],
              ),
            ),
              if(isFontsActive && !isColorActive)...[
                Positioned(
                  bottom:
                  MediaQuery.of(context).padding.bottom +
                      16, // Adjust position
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Font Selector (horizontal list of font names)
                      SizedBox(
                        height: 40, // Height for font names
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:
                          availableFonts.map((fontFamily) {
                            return GestureDetector(
                              onTap:
                                  () => context
                                  .read<TextEditingCubit>()
                                  .changeCurrentFontType(fontFamily),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                  state.textPropertiesForStory.fontType ==
                                      fontFamily
                                      ? Colors.white.withOpacity(0.8)
                                      : Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Aa',
                                    style: TextStyle(
                                      color:
                                      state
                                          .textPropertiesForStory
                                          .fontType ==
                                          fontFamily
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
              ]else if (isColorActive &&!isFontsActive)...[
                  // Color Palette
                  Positioned(
                    bottom:
                    MediaQuery.of(context).padding.bottom +
                        16, // Adjust position
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: ListView(
                          scrollDirection: Axis.horizontal,shrinkWrap: true,
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
                                (color) => GestureDetector(
                              onTap: () {
                                context
                                    .read<TextEditingCubit>()
                                    .changeCurrentTextColor(color);
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                    state
                                        .textPropertiesForStory
                                        .color ==
                                        color
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
                    ),
                  ),
                ],
              ]
        );
      },
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
          color:
              isActive
                  ? ColorManager.primaryColor
                  : ColorManager.primaryColor.withOpacity(0.3),
        ),
        child: SvgPicture.asset(assets, color: isActive ? Colors.white : null),
      ),
    );
  }
}
