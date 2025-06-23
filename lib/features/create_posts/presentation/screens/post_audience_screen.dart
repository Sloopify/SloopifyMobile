import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/utils/helper/app_extensions/post_audience_extention.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/freinds_list.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../blocs/post_friends_cubit/post_freinds_cubit.dart';

enum PostAudience { public, friends, friendsExcept, specificFriends, onlyMe }

class PostAudienceScreen extends StatelessWidget {
  const PostAudienceScreen({super.key});

  static const routeName = "post_Audience_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Post Audience"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p10,
            ),
            child: BlocBuilder<CreatePostCubit, CreatePostState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Who can see your post?",
                      style: AppTheme.headline4.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.vGap1,
                    Text(
                      """Your post may show up in News Feed, on your profile, in search results.
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

  List<Widget> _buildRadioGroup(CreatePostState state, BuildContext context) {
    return PostAudience.values
        .map(
          (audience) => Directionality(
            textDirection: TextDirection.ltr,
            child: RadioListTile<PostAudience>(
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
              title: InkWell(
                onTap: () {
                  if (audience == PostAudience.friendsExcept ||
                      audience == PostAudience.specificFriends) {
                    Navigator.pushNamed(
                      context,
                      FriendsList.routeName,
                      arguments: {
                        "create_post_cubit": context.read<CreatePostCubit>(),
                        "post_friends_cubit":
                            context.read<PostFriendsCubit>()..getFriendsList(),
                      },
                    );
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      audience.getSvg(),
                      color:
                          audience == PostAudience.friends
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
                    if (audience == PostAudience.friendsExcept ||
                        audience == PostAudience.specificFriends) ...[
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: ColorManager.black,
                      ),
                    ],
                  ],
                ),
              ),
              value: audience,
              groupValue: state.regularPostEntity.postAudience,
              selected: state.regularPostEntity.postAudience == audience,
              onChanged: (value) {
                context.read<CreatePostCubit>().setPostAudience(value!);
                if (audience == PostAudience.friendsExcept ||
                    audience == PostAudience.specificFriends) {
                  Navigator.pushNamed(
                    context,
                    FriendsList.routeName,
                    arguments: {
                      "create_post_cubit": context.read<CreatePostCubit>(),
                      "post_friends_cubit":
                          context.read<PostFriendsCubit>()..getFriendsList(),
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
