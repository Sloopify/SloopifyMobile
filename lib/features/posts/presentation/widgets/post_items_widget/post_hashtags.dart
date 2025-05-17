import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';

class PostHashtags extends StatelessWidget {
  final PostEntity postEntity;

  const PostHashtags({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      spacing: 4,
      direction: Axis.horizontal,
      children:
          postEntity.hashtags!
              .map(
                (e) => Text(
                  '#$e',
                  style: AppTheme.bodyText3.copyWith(
                    color: ColorManager.textBlue,
                  ),
                ),
              )
              .toList(),
    );
  }
}
