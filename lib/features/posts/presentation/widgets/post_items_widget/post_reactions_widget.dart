
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';
import 'package:sloopify_mobile/features/posts/presentation/screens/comments_screen.dart';

class PostReactionsWidget extends StatelessWidget {
  final PostEntity postEntity;
  const PostReactionsWidget({super.key,required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: (){},
              child: SvgPicture.asset(AssetsManager.like),
            ),
            if(postEntity.numberOfLikes>0)...[
              Gaps.hGap1,
              Text(postEntity.numberOfLikes.toString(),style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),),
            ]


          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CommentsScreen(postEntity: postEntity)));
              },
              child: SvgPicture.asset(AssetsManager.comment),
            ),
            if(postEntity.numberOfComments>0)...[
              Gaps.hGap1,
              Text(postEntity.numberOfComments.toString(),style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),),
            ]


          ],
        ),
        InkWell(
          onTap: (){},
          child: SvgPicture.asset(AssetsManager.share),
        ),
        InkWell(
          onTap: (){},
          child: SvgPicture.asset(AssetsManager.save),
        ),

      ],
    );
  }
}
