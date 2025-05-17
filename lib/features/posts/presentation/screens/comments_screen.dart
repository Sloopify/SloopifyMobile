import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_comment_widgets/post_comments_header.dart';

class CommentsScreen extends StatelessWidget {
  final PostEntity postEntity;

  const CommentsScreen({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: "Comments",
        actions: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              AssetsManager.share,
              color: ColorManager.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: PostCommentsHeader(postEntity: postEntity),
              ),
            ];
          },
          body: SizedBox.shrink(),
        ),
      ),
    );
  }
}
