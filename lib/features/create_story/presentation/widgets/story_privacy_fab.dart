import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_sheet.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';

class StoryPrivacyFab extends StatelessWidget {
  const StoryPrivacyFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: () {
        CustomSheet.show(
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: context.read<PostFriendsCubit>(),
              ),
              BlocProvider.value(
                value: context.read<StoryEditorCubit>(),
              ),
            ],
            child: PrivacySheet(),
          ),
          context: context,
          barrierColor: ColorManager.black.withOpacity(0.2),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: ColorManager.white,
      child: SvgPicture.asset(
        AssetsManager.settings,
        color: ColorManager.black,
      ),
    );
  }
}

class PrivacySheet extends StatelessWidget {
  const PrivacySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p20,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
                StoryAudienceScreen.routeName, arguments: {
              'post_friends_cubit': context.read<PostFriendsCubit>(),
              "story_editor_cubit": context.read<StoryEditorCubit>()
            });
          },
          child: Row(
            children: [
              SvgPicture.asset(AssetsManager.storyPrivacy),
              Gaps.hGap3,
              Text(
                "Privacy",
                style: AppTheme.headline3.copyWith(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
