import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/core/utils/helper/app_extensions/stoty_audience_extension.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/story_friends_list.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/managers/theme_manager.dart';
import '../../../../../core/ui/widgets/custom_app_bar.dart';
import '../../../../create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';

enum StoryAudience { public, friends, friendsExcept, specificFriends }

class StoryAudienceScreen extends StatelessWidget {
  const StoryAudienceScreen({super.key});

  static const routeName = "story_audience_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Story Audience"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p10,
            ),
            child: BlocBuilder<StoryEditorCubit, StoryEditorState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Who can see your story?",
                      style: AppTheme.headline4.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.vGap1,
                    Text(
                      """Your story may show up in News Feed, on your profile, in search results. 
Your default audience is set to Friends, but you can change the audience of this specific post.""",
                      style: AppTheme.headline4.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gaps.vGap2,
                    Text(
                      "choose Audience",
                      style: AppTheme.headline4.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.vGap1,
                    ..._buildRadioGroup(state, context),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRadioGroup(StoryEditorState state, BuildContext context) {
    return StoryAudience.values
        .map(
          (audience) => Directionality(
            textDirection: TextDirection.ltr,
            child: RadioListTile<StoryAudience>(
              isThreeLine: true,
              contentPadding: EdgeInsets.zero,
              activeColor: ColorManager.primaryColor,
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  audience.getDescription(),
                  style: AppTheme.bodyText3,
                ),
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    audience.getSvg(),
                    color:
                        audience == StoryAudience.friends
                            ? ColorManager.black
                            : null,
                  ),
                  Gaps.hGap2,
                  Text(
                    audience.getText(),
                    style: AppTheme.bodyText3.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (audience == StoryAudience.friendsExcept ||
                      audience == StoryAudience.specificFriends) ...[
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: ColorManager.black,
                    ),
                  ],
                ],
              ),
              value: audience,
              groupValue: state.privacy,
              selected: state.privacy == audience,
              onChanged: (value) {
                context.read<StoryEditorCubit>().setStoryAudience(value!);
                if (audience == StoryAudience.friendsExcept ||
                    audience == StoryAudience.specificFriends) {
                  Navigator.pushNamed(
                    context,
                    StoryFriendsList.routeName,
                    arguments: {
                      "story_editor_cubit": context.read<StoryEditorCubit>(),
                      "post_friends_cubit":
                          context.read<PostFriendsCubit>()..setFromStory()..getFriendsList(),
                    },
                  );
                }
              },
            ),
          ),
        )
        .toList();
  }
}
