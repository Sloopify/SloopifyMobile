import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/features/home/presentation/widgets/ai_system_widgets/ads_categories_list.dart';
import 'package:sloopify_mobile/features/home/presentation/widgets/ai_system_widgets/ask_robot_widget.dart';
import 'package:sloopify_mobile/features/home/presentation/widgets/ai_system_widgets/find_your_peers.dart';

import '../../../../core/managers/assets_managers.dart';
import '../widgets/ai_system_widgets/header_ai_system.dart';
import '../widgets/ai_system_widgets/news_widget.dart';

class AiSystemScreen extends StatelessWidget {
  const AiSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.p20,vertical: AppPadding.p4),
          child: HeaderAiSystem(),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p20,
                vertical: AppPadding.p10,
              ),
              child: Column(
                children: [
                  AskRobotWidget(),
                  Gaps.vGap2,
                  NewsWidget(),
                  Gaps.vGap2,
                  FindYourPeers(),
                  Gaps.vGap1,
                  AdsCategoriesList(),
                  Gaps.vGap3,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
