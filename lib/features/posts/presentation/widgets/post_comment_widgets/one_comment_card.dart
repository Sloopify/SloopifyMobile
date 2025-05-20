import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/commet_entity.dart';
import 'package:sloopify_mobile/core/external_packages/comment_tree-master/lib/comment_tree.dart';
import 'package:sloopify_mobile/features/posts/presentation/blocs/comment_reaction_cubit/comment_reactions_cubit.dart';

import '../../../../../core/managers/app_dimentions.dart';

class OneCommentCard extends StatelessWidget {
  final CommentEntity commentEntity;

  const OneCommentCard({super.key, required this.commentEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentTreeWidget<Comment, Comment>(
          Comment(
            avatar: commentEntity.publisherProfilePhoto,
            userName: commentEntity.publisherName,
            content: commentEntity.content,
          ),
          commentEntity.replies
              .map(
                (reply) => Comment(
                  avatar: reply.publisherProfilePhoto,
                  userName: reply.publisherName,
                  content: reply.content,
                ),
              )
              .toList(),
          treeThemeData: TreeThemeData(
            lineColor: commentEntity.replies.isNotEmpty?ColorManager.disActive.withOpacity(0.5):Colors.transparent,
            lineWidth: 1,
          ),
          avatarRoot: (context, data) => _buildCommentAvatar(),
          avatarChild: (context, data) => _buildCommentAvatar(),
          contentChild:
              (context, data) => _buildComment(
                data,
                commentEntity:
                    commentEntity.replies
                        .where((element) => element.content == data.content!)
                        .first,
                context: context
              ),
          contentRoot:
              (context, data) => _buildComment(data, commentEntity: commentEntity,context: context),
        ),
      ],
    );
  }

  Widget _buildComment(Comment data, {required CommentEntity commentEntity,required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (data.content != null && data.content!.isNotEmpty)
            ? Container(
          padding:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(color: ColorManager.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.userName ?? '',
                        style: AppTheme.bodyText3.copyWith(
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(AssetsManager.postInfo),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          data.content ?? "",
                          style: AppTheme.bodyText3.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
            : SizedBox.shrink(),
        Gaps.vGap1,
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  context.read<CommentInteractionCubit>().toggleLike(commentEntity.id);
                },
                child: SvgPicture.asset(
                  AssetsManager.like,
                  color: commentEntity.isLiked ? ColorManager.primaryColor : null,
                ),
              ),
              Gaps.hGap1,
              Text(
                commentEntity.numberOfLike.toString(),
                style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),
              ),
              Gaps.hGap3,
              Text(
                'reply',
                style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  PreferredSize _buildCommentAvatar() {
    return PreferredSize(
      preferredSize: const Size.fromRadius(20),
      child: GeneralImage.circular(
        radius: 40,
        fit: BoxFit.cover,
        isNetworkImage: false,
        image: AssetsManager.manExample,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorManager.primaryColor, width: 1.5),
        ),
      ),
    );
  }
}
