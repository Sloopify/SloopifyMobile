import 'package:flutter/cupertino.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_read_more_text.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_items_widget/post_hashtags.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_items_widget/post_images_slider.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_items_widget/post_poll.dart';

class PostContent extends StatelessWidget {
  final PostEntity postEntity;

  PostContent({super.key, required this.postEntity});

  final dotController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomReadMoreText(
          text: postEntity.content,
          trimLines: 5,
          textStyle: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),
        ),
        if (postEntity.hashtags != null && postEntity.hashtags!.isNotEmpty) ...[
          Gaps.vGap1,
          PostHashtags(postEntity: postEntity),
        ],
        if (postEntity.images != null && postEntity.images!.isNotEmpty) ...[
          Gaps.vGap2,
          PostImagesSlider(postImages: postEntity.images!),
        ],
        if (postEntity.polls != null) ...[
          PostPoll(postEntity: postEntity),
          Gaps.vGap2,
        ],
      ],
    );
  }
}
