import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_footer.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/widgets/select_frind_item.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../blocs/post_friends_cubit/post_freinds_cubit.dart';

class MentionFriends extends StatelessWidget {
  final bool fromStory;
  static const routeName = "mention_friends";

  const MentionFriends({super.key, this.fromStory = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Mention friends"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p10,
          ),
          child: BlocBuilder<PostFriendsCubit, PostFriendsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: "Serach for a friend",
                          withTitle: false,
                          onChanged: (value) {
                            context
                                .read<PostFriendsCubit>()
                                .setSearchFriendName(value);
                          },
                        ),
                      ),
                      Gaps.hGap2,
                      SizedBox(
                        width: 70,
                        height: 50,
                        child: CustomElevatedButton(
                          label: "Find",
                          onPressed: () {
                            context
                                .read<PostFriendsCubit>()
                                .searchFriendsList();
                          },
                          backgroundColor: ColorManager.primaryColor
                              .withOpacity(0.3),
                          borderSide: BorderSide(
                            color: ColorManager.primaryColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap3,
                  if (state.getAllFriendStatus == GetAllFriendStatus.loading &&
                      state.allFriends.isEmpty) ...[
                    Center(child: CircularProgressIndicator()),
                  ] else if (state.getAllFriendStatus ==
                      GetAllFriendStatus.offline) ...[
                    Center(
                      child: Text("you are offline", style: AppTheme.headline4),
                    ),
                  ] else if (state.getAllFriendStatus ==
                      GetAllFriendStatus.error) ...[
                    Center(
                      child: Text(
                        state.errorMessage,
                        style: AppTheme.headline4,
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: SmartRefresher(
                        controller:
                            context.read<PostFriendsCubit>().refreshController,
                        enablePullUp: true,
                        enablePullDown: true,
                        onRefresh:
                            () => context.read<PostFriendsCubit>().onRefresh(),
                        onLoading:
                            () => context.read<PostFriendsCubit>().onLoadMore(),
                        footer: customFooter,
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemCount: state.allFriends.length,
                          itemBuilder: (context, index) {
                            bool isSelcetd =
                                fromStory
                                    ? state.mentionFriendsStory.contains(
                                      MentionFriendStory(
                                        friendId: state.allFriends[index].id,
                                        friendName:
                                            '${state.allFriends[index].firstName} ${state.allFriends[index].lastName}',
                                      ),
                                    )
                                    : state.selectedMentionFriends.contains(
                                      state.allFriends[index].id,
                                    );
                            return SelectFriendItem(
                              friendEntity: state.allFriends[index],
                              onChanged: (value) {
                                if (!fromStory) {
                                  context
                                      .read<PostFriendsCubit>()
                                      .toggleSelectionMentionFriends(
                                        state.allFriends[index].id,
                                      );
                                  context
                                      .read<CreatePostCubit>()
                                      .setMentionFriends(
                                        state.selectedMentionFriends,
                                      );
                                } else {
                                  context
                                      .read<PostFriendsCubit>()
                                      .toggleSelectionMentionStoryFriends(
                                        MentionFriendStory(
                                          friendId: state.allFriends[index].id,
                                          friendName:
                                              '${state.allFriends[index].firstName} ${state.allFriends[index].lastName}',
                                        ),
                                      );
                                }
                                print(state.mentionFriendsStory);
                              },
                              initValue: isSelcetd,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Gaps.vGap2;
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        color: ColorManager.white,
                        child: CustomElevatedButton(
                          label: "Done",
                          onPressed: () {
                            if (fromStory) {
                              for (
                              int i = 0;
                              i < state.mentionFriendsStory.length;
                              i++
                              ) {
                                context
                                    .read<StoryEditorCubit>()
                                    .addMentionElement(
                                  friendId: state.mentionFriendsStory[i].friendId,
                                  offset: Offset(
                                    MediaQuery.of(context).size.width / 2,
                                    MediaQuery.of(context).size.height / 2,
                                  ),
                                  friendName:state.mentionFriendsStory[i].friendName,
                                );
                              }
                              context.read<PostFriendsCubit>().emptyMentionFriends();

                            }
                            Navigator.of(context).pop();

                          },
                          width: MediaQuery.of(context).size.width * 0.7,
                          borderSide: BorderSide(
                            color: ColorManager.primaryColor.withOpacity(0.3),
                          ),
                          backgroundColor: ColorManager.primaryColor
                              .withOpacity(0.3),
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
