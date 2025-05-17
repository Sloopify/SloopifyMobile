import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../posts/presentation/widgets/home_posts_widget/posts_lists.dart';
import 'home_header.dart';
import 'home_search.dart';
import 'home_stories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap2,
        HomeHeader(),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.p20,vertical: AppPadding.p10),
          child: HomeStories(),
        ),
        Gaps.vGap2,
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: HomeSearch(),
        ),
        Gaps.vGap2,

        Expanded(child: PostsLists()),
      ],
    );
  }
}
