import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';

class PostFeelings extends StatelessWidget {
  final PostEntity postEntity;

  const PostFeelings({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Gaps.hGap16,
        Text('feeling ${postEntity.feelings}', style: AppTheme.bodyText3.copyWith(fontFamily: kanitFonFamily)),
        Gaps.hGap2,
        if (postEntity.friendsSharing != null &&
            postEntity.friendsSharing!.isNotEmpty) ...[
          if (postEntity.friendsSharing!.length > 1) ...[
            Text(
              'with ${postEntity.friendsSharing![0]} & ${postEntity.friendsSharing!.length - 1} others',
              style: AppTheme.bodyText3.copyWith(
                  fontFamily: kanitFonFamily

              ),
            ),
          ] else ...[
            Text(
              'with ${postEntity.friendsSharing!.first}',
              style: AppTheme.bodyText3.copyWith(
                fontSize: 12,
                fontFamily: kanitFonFamily
              ),
            ),
          ],
        ],
      ],
    );
  }
}
