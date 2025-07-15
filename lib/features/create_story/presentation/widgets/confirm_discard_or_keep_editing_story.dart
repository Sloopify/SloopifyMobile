import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';

class ConfirmDiscardOrKeepEditingStory extends StatelessWidget {
  const ConfirmDiscardOrKeepEditingStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Discard Story?',
            style: AppTheme.headline4.copyWith(color: ColorManager.black),
          ),
          Gaps.vGap1,
          Text(
            'You will lose this story and any changes you have made to it',
            style: AppTheme.bodyText3.copyWith(color: ColorManager.black),
          ),
          Gaps.vGap2,
          _buildOption(
            text: "Keep Editing",
            onTap: () => Navigator.of(context).pop(),
            icon: Icons.edit,
          ),
          Gaps.vGap1,
          _buildOption(
            text: "Discard Story",
            onTap: () {
              context.read<StoryEditorCubit>().clearAll();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required String text,
    required Function() onTap,
    required IconData icon,
  }) {
    return ListTile(
      onTap: onTap,
      titleTextStyle: AppTheme.headline4.copyWith(color: ColorManager.black),
      title: Text(text),
      contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
      leading: Container(
        padding: EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorManager.lightGray,
        ),
        child: Icon(icon, size: 18, color: ColorManager.black),
      ),
    );
  }
}
