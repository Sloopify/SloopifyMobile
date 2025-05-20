import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/frined_entity.dart';

import '../../../../../core/managers/app_dimentions.dart';

class PostSendFriendsSheet extends StatelessWidget {
  final List<FriendEntity> friends;

  const PostSendFriendsSheet({super.key, required this.friends});

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
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  hintText: "search for friends",
                  withTitle: false,
                ),
              ),
              Gaps.hGap2,
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AssetsManager.share),
              ),
            ],
          ),
          Gaps.vGap2,
          Divider(
            thickness: 0.5,
            color: ColorManager.disActive.withOpacity(0.5),
          ),
          Gaps.vGap2,

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GeneralImage.circular(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManager.primaryShade3,
                      ColorManager.primaryShade4,
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.primaryColor,
                    width: 2,
                  ),
                ),
                radius: 50,
                isNetworkImage: false,
                image: AssetsManager.manExample,
                fit: BoxFit.cover,
              ),
              Gaps.hGap1,
              Text(
                "Add post to your story",
                style: AppTheme.headline4.copyWith(color: ColorManager.black),
              ),
              Spacer(),
              Container(
                alignment: Alignment.center,
                height: 35,
                width: 65,
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.add,color: ColorManager.white,size: 15,),
              ),
            ],
          ),
          Gaps.vGap2,
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.separated(
              itemCount: friends.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GeneralImage.circular(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorManager.primaryShade3,
                            ColorManager.primaryShade4,
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorManager.primaryColor,
                          width: 2,
                        ),
                      ),
                      radius: 50,
                      isNetworkImage: false,
                      image: friends[index].profileImge,
                      fit: BoxFit.cover,
                    ),
                    Gaps.hGap1,
                    Text(
                      friends[index].name,
                      style: AppTheme.headline4.copyWith(
                        color: ColorManager.black,
                      ),
                    ),
                    if (friends[index].isSent) ...[
                      Spacer(),
                      SizedBox(
                        height: 35,
                        width: 65,
                        child: CustomElevatedButton(
                          isBold: true,
                          label: "Sent",
                          onPressed: () {},
                          backgroundColor: ColorManager.white,
                          foregroundColor: ColorManager.primaryColor,
                          borderSide: BorderSide(
                            color: ColorManager.primaryColor,
                          ),
                        ),
                      ),
                    ] else ...[
                      Spacer(),

                      SizedBox(
                        height: 35,
                        width: 65,
                        child: CustomElevatedButton(
                          isBold: true,
                          label: "Send",
                          onPressed: () {},
                          backgroundColor: ColorManager.primaryColor,
                          foregroundColor: ColorManager.white,
                        ),
                      ),
                    ],
                  ],
                );
              }, separatorBuilder: (BuildContext context, int index) {
                return Gaps.vGap1;
            },
            ),
          ),
        ],
      ),
    );
  }
}
