import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/theme_manager.dart';
import '../screens/story_editor_screen.dart';

class EditingTopToolBar extends StatelessWidget {
  final EditingMode editingMode;
  final Function()? undoDrawing;
  final Function() onBack;
  final Function() onDone;

  const EditingTopToolBar({
    super.key,
    required this.editingMode,
    this.undoDrawing,
    required this.onDone,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          if (editingMode == EditingMode.draw) ...[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.brush,
                    color: Colors.white,
                  ),
                ),
                Gaps.hGap2,
                GestureDetector(
                  onTap: undoDrawing,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.undo, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
          GestureDetector(
            onTap: onDone,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Done",
                style: AppTheme.bodyText3.copyWith(
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
