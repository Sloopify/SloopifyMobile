import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/widgets/select_frind_item.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../blocs/post_friends_cubit/post_freinds_cubit.dart';

class MentionFriends extends StatelessWidget {
  static const routeName = "mention_friends";

  const MentionFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title:
       "Mention friends"
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
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
                                color: ColorManager.primaryColor.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap3,
                      if (state.getAllFriendStatus ==
                          GetAllFriendStatus.loading) ...[
                        Center(child: CircularProgressIndicator()),
                      ] else if (state.getAllFriendStatus ==
                          GetAllFriendStatus.offline) ...[
                        Center(
                          child: Text(
                            "you are offline",
                            style: AppTheme.headline4,
                          ),
                        ),
                      ] else if (state.getAllFriendStatus ==
                          GetAllFriendStatus.error) ...[
                        Center(
                          child: Text(
                            "some thing went error, please try again later!",
                            style: AppTheme.headline4,
                          ),
                        ),
                      ] else
                        Expanded(
                          child: ListView.separated(
                            itemCount: state.allFriends.length,
                            itemBuilder: (context, index) {
                              bool isSelcetd = state.selectedMentionFriends
                                  .contains(state.allFriends[index].id);
                              return SelectFriendItem(
                                friendEntity: state.allFriends[index],
                                onChanged: (value) {
                                  context
                                      .read<PostFriendsCubit>()
                                      .toggleSelectionMentionFriends(
                                    state.allFriends[index].id,
                                  );
                                  context
                                      .read<CreatePostCubit>()
                                      .setMentionFriends(
                                    state.selectedSpecificFriends,
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

                    ],
                  );
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
                  Navigator.of(context).pop();
                },
                width: MediaQuery.of(context).size.width * 0.7,
                borderSide: BorderSide(
                  color: ColorManager.primaryColor.withOpacity(0.3),
                ),
                backgroundColor: ColorManager.primaryColor.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
