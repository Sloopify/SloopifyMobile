import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/select_media_gallery_story.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_editor_screen.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/text_story_editor.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import 'camera_capture.dart';

class CreateStoryFirstStep extends StatelessWidget {
  const CreateStoryFirstStep({super.key});

  static const routeName = " create_story_first_step";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: "Create Story",
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  StoryAudienceScreen.routeName,
                  arguments: {
                    "story_editor_cubit": context.read<StoryEditorCubit>(),
                    "post_friends_cubit": context.read<PostFriendsCubit>(),
                  },
                );
              },
              child: SvgPicture.asset(AssetsManager.storyAudience),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.15,
          ),
          child: Column(
            children: [
              Divider(
                thickness: 0.5,
                color: ColorManager.disActive.withOpacity(0.5),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                  vertical: AppPadding.p4,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          TextStoryEditor.routeName,
                          arguments: {
                            "story_editor_cubit":
                                context.read<StoryEditorCubit>(),
                            "post_friends_cubit":
                                context.read<PostFriendsCubit>(),
                            "add_location_cubit":
                                context.read<AddLocationCubit>(),
                            "feelings_activities_cubit":
                                context.read<FeelingsActivitiesCubit>(),
                          },
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: ColorManager.gray600),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AssetsManager.text),
                            Gaps.vGap1,
                            Text(
                              "Text",
                              style: AppTheme.headline4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.gray600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gaps.hGap4,
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            SelectMediaGalleryStory.routeName,
                            arguments: {
                              "story_editor_cubit":
                                  context.read<StoryEditorCubit>(),
                              "post_friends_cubit":
                                  context.read<PostFriendsCubit>(),
                              "add_location_cubit":
                                  context.read<AddLocationCubit>(),
                              "feelings_activities_cubit":
                                  context.read<FeelingsActivitiesCubit>(),
                              "isMultiSelection": true,
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: ColorManager.gray600),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AssetsManager.multiPhoto),
                              Gaps.vGap1,
                              Text(
                                "Select multi elements",
                                style: AppTheme.headline4.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.gray600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: ColorManager.disActive.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
      body: SelectMediaGalleryStory(isMultiSelection: false),
      floatingActionButton: _buildOpenCameraVideoFab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget _buildOpenCameraVideoFab(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.of(context).pushNamed(
            CameraCaptureScreen.routeName,
            arguments: {
              "story_editor_cubit": context.read<StoryEditorCubit>(),
              "post_friends_cubit": context.read<PostFriendsCubit>(),
              "add_location_cubit": context.read<AddLocationCubit>(),
              "feelings_activities_cubit":
                  context.read<FeelingsActivitiesCubit>(),
            },
          ),
      child: Container(
        padding: EdgeInsets.all(AppPadding.p10),
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(AssetsManager.openCamera),
      ),
    );
  }
}
