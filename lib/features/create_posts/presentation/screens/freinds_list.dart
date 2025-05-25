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

class FriendsList extends StatelessWidget {
  final bool isFriendsExcept;
  final bool isSpecificFriends;
  final bool isMentionFriends;

  const FriendsList({
    super.key,
    this.isFriendsExcept = false,
    this.isMentionFriends = false,
    this.isSpecificFriends = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title:
            isFriendsExcept
                ? "Friends except"
                : isSpecificFriends
                ? "Specific friends"
                : "Mention friends",
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
              child: BlocBuilder<CreatePostCubit, CreatePostState>(
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
                                    .read<CreatePostCubit>()
                                    .setSearchFriendNameField(value);
                              },
                            ),
                          ),
                          Gaps.hGap2,
                          SizedBox(
                            width: 70,
                            height:50,
                            child: CustomElevatedButton(
                              label: "Find",
                              onPressed: () {},
                              backgroundColor: ColorManager.primaryColor.withOpacity(0.3),
                              borderSide: BorderSide(color: ColorManager.primaryColor.withOpacity(0.3)),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap3,
                      if (state.getAllFriendStatus ==
                          GetAllFriendStatus.loading) ...[
                        Center(child: CircularProgressIndicator()),
                      ] else ...[
                        if(isMentionFriends)
                          ...[
                            Text("Suggested friends",style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.bold),)
                          ],
                        Expanded(
                          child: ListView.separated(
                            itemCount: state.allFriends.length,
                            itemBuilder: (context, index) {
                              return SelectFriendItem(
                                friendEntity: state.allFriends[index],
                                onChanged: (value) {
                                  context
                                      .read<CreatePostCubit>()
                                      .selectFriendEntity(
                                        state.allFriends[index],
                                      );
                                  print(state.createPostEntity.friends.length);
                                },
                                initValue: state.createPostEntity.friends
                                    .contains(state.allFriends[index]),
                              );
                            }, separatorBuilder: (BuildContext context, int index) {
                              return Gaps.vGap2;
                          },
                          ),
                        ),
                      ],
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
                onPressed: () {},
                width: MediaQuery.of(context).size.width * 0.7,
                borderSide: BorderSide(color:ColorManager.primaryColor.withOpacity(0.3) ),
                backgroundColor: ColorManager.primaryColor.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
