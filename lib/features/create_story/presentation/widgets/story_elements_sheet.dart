import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';

import '../../../../core/managers/app_gaps.dart' show Gaps;

class StoryElementsSheet extends StatelessWidget {
  const StoryElementsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryEditorCubit, StoryEditorState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p10,
            vertical: AppPadding.p10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElementOption(
                    context: context,
                    text: 'Location',
                    asset: AssetsManager.storyLocation,
                    onTap: () {},
                  ),
                  _buildElementOption(
                    context: context,
                    text: 'Poll',
                    asset: AssetsManager.storyPoll,
                    onTap: () {},
                  ),
                ],
              ),
              Gaps.vGap1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElementOption(context: context,
                    text: 'Mention',
                    asset: AssetsManager.storyMention,
                    onTap: () {
                    context.read<StoryEditorCubit>().addMentionElement(friendId: 1, friendName: 'Nour Alkhalil');
                    },
                  ),
                  _buildElementOption(
                    context: context,
                    text: 'Audio',
                    asset: AssetsManager.storyAudio,
                    onTap: () {},
                  ),
                ],
              ),
              Gaps.vGap1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElementOption(
                    context: context,
                    text: 'Clock',
                    asset: AssetsManager.storyClock,
                    onTap: () {},
                  ),
                  _buildElementOption(
                    context: context,
                    text: '34',
                    asset: AssetsManager.storyWeather,
                    onTap: () {
                      context.read<StoryEditorCubit>().addTemperatureElement();
                    },
                  ),
                ],
              ),
              Gaps.vGap1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElementOption(
                    context: context,
                    text: 'Feeling',
                    asset: AssetsManager.storyFeeling,
                    onTap: () {},
                  ),
                  _buildElementOption(
                    context: context,
                    text: 'Gif',
                    asset: AssetsManager.storyGif,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildElementOption({
    required String text,
    required String asset,
    required Function() onTap,
    required BuildContext context
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.35,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p10,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManager.lightGray),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: ColorManager.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(asset),
            Gaps.hGap1,
            Text(
              text,
              style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
