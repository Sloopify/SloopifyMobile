import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/ui/widgets/custom_app_bar.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/ui/widgets/custom_footer.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../create_posts/presentation/widgets/select_frind_item.dart';

class StoryFriendsList extends StatelessWidget {
  const StoryFriendsList({super.key});

  static const routeName = "story_friends_list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title:
            context.read<StoryEditorCubit>().state.privacy ==
                    StoryAudience.friendsExcept
                ? "Friends except"
                : "Specific friends",
      ),
      body: SafeArea(
        child: BlocBuilder<PostFriendsCubit, PostFriendsState>(
          builder: (context, state) {
            if (state.getAllFriendStatus == GetAllFriendStatus.loading &&
                state.allFriends.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else if (state.getAllFriendStatus == GetAllFriendStatus.offline) {
              return Text(
                "You are offline",
                style: AppTheme.headline4.copyWith(color: ColorManager.black),
              );
            } else if (state.getAllFriendStatus == GetAllFriendStatus.error) {
              return Text(
                "Some thing went wrong",
                style: AppTheme.headline4.copyWith(color: ColorManager.black),
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                  vertical: AppPadding.p10,
                ),
                child: Column(
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
                    if (context.read<StoryEditorCubit>().state.privacy ==
                        StoryAudience.specificFriends) ...[
                      Expanded(
                        child: SmartRefresher(
                          controller:
                              context
                                  .read<PostFriendsCubit>()
                                  .refreshController,
                          enablePullUp: true,
                          enablePullDown: true,
                          onRefresh:
                              () =>
                                  context.read<PostFriendsCubit>().onRefresh(),
                          onLoading:
                              () =>
                                  context.read<PostFriendsCubit>().onLoadMore(),
                          footer: customFooter,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemCount: state.allFriends.length,
                            itemBuilder: (context, index) {
                              bool isSelcetd = state.selectedSpecificFriends
                                  .contains(state.allFriends[index].id);
                              return SelectFriendItem(
                                friendEntity: state.allFriends[index],
                                onChanged: (value) {
                                  context
                                      .read<PostFriendsCubit>()
                                      .toggleSelectSpecificFriends(
                                        state.allFriends[index].id,
                                      );
                                },
                                initValue: isSelcetd,
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Gaps.vGap2;
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        color: ColorManager.white,
                        child: CustomElevatedButton(
                          label: "Done",
                          onPressed: () {
                            context
                                .read<StoryEditorCubit>()
                                .setListOfSpecificFriends(
                                  state.selectedSpecificFriends,
                                );
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
                    ] else if (context.read<StoryEditorCubit>().state.privacy ==
                        StoryAudience.friendsExcept) ...[
                      Expanded(
                        child: SmartRefresher(
                          controller:
                              context
                                  .read<PostFriendsCubit>()
                                  .refreshController,
                          enablePullUp: true,
                          enablePullDown: true,
                          onRefresh:
                              () =>
                                  context.read<PostFriendsCubit>().onRefresh(),
                          onLoading:
                              () =>
                                  context.read<PostFriendsCubit>().onLoadMore(),
                          footer: customFooter,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemCount: state.allFriends.length,
                            itemBuilder: (context, index) {
                              bool isSelcetd = state.selectedFriendsExcept
                                  .contains(state.allFriends[index].id);
                              return SelectFriendItem(
                                friendEntity: state.allFriends[index],
                                onChanged: (value) {
                                  context
                                      .read<PostFriendsCubit>()
                                      .toggleSelectFriendsExcept(
                                        state.allFriends[index].id,
                                      );
                                  print(state.selectedFriendsExcept);
                                },
                                initValue: isSelcetd,
                              );
                            },
                            separatorBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              return Gaps.vGap2;
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        color: ColorManager.white,
                        child: CustomElevatedButton(
                          label: "Done",
                          onPressed: () {
                            context
                                .read<StoryEditorCubit>()
                                .setListOfFriendsExcept(
                                  state.selectedSpecificFriends,
                                );

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
                    ],
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
