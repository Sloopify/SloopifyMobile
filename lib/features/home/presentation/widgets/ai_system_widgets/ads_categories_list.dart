import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/features/home/presentation/widgets/ai_system_widgets/ads_category_item.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/managers/theme_manager.dart';

class AdsCategoriesList extends StatelessWidget {
  const AdsCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOrWidget(),
        Gaps.vGap2,
        GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.9
          ),
          itemBuilder: (BuildContext context, int index) {
            return AdsCategoryItem(
              image: AssetsManager.homeExample2,
              categoryName: "house",
            );
          },
        ),
      ],
    );
  }
  Widget _buildOrWidget() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: ColorManager.primaryColor,
            thickness: 1,
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Text(
            'Advertisements Category',
            style: AppTheme.bodyText3.copyWith(
              color: ColorManager.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: ColorManager.primaryColor,
            thickness: 1,

          ),
        ),
      ],
    );
  }

}
