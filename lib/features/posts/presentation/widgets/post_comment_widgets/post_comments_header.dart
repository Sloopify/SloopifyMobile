import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_items_widget/post_content.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/managers/assets_managers.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/managers/theme_manager.dart';

class PostCommentsHeader extends StatelessWidget {
  final PostEntity postEntity;

  const PostCommentsHeader({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                image: postEntity.profileImage,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postEntity.publisherName,
                      style: AppTheme.headline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '@ ${postEntity.publisherName}',
                          style: AppTheme.bodyText3.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(AssetsManager.postInfo),
              ),
            ],
          ),
          Divider(thickness: 0.5, color: ColorManager.black),
          PostContent(postEntity: postEntity),
          Gaps.vGap1,
          Row(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(AssetsManager.like),
                  ),
                  if (postEntity.numberOfLikes > 0) ...[
                    Gaps.hGap1,
                    Text(
                      postEntity.numberOfLikes.toString(),
                      style: AppTheme.bodyText3.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
              Gaps.hGap2,
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(AssetsManager.comment),
                  ),
                  if (postEntity.numberOfComments > 0) ...[
                    Gaps.hGap1,
                    Text(
                      postEntity.numberOfComments.toString(),
                      style: AppTheme.bodyText3.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          Gaps.vGap1,
          Divider(thickness: 0.5,color: ColorManager.black,),
        ],
      ),
    );
  }
}
