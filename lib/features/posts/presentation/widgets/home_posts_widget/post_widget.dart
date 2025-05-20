import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';

import '../post_items_widget/post_content.dart';
import '../post_items_widget/post_fellings.dart';
import '../post_items_widget/post_publisher_info.dart';
import '../post_items_widget/post_reactions_widget.dart';

class PostWidget extends StatelessWidget {
  final PostEntity postEntity;

  const PostWidget({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      padding: EdgeInsets.all(AppPadding.p16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            color: ColorManager.black.withOpacity(0.5),
            blurRadius: 4,
            spreadRadius: 0,
          ),
          BoxShadow(
            offset: Offset(0, -4),
            color: ColorManager.bottomNavigationBackGround.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostPublisherInfo(postEntity: postEntity),
          PostFeelings(postEntity: postEntity),
          PostContent(postEntity: postEntity),
          Align(
            alignment: Alignment.bottomCenter,
            child: PostReactionsWidget(postEntity: postEntity),
          ),
        ],
      ),
    );
  }
}
