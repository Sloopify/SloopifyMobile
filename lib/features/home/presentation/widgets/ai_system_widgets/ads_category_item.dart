import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';

class AdsCategoryItem extends StatelessWidget {
  final String image;
  final String categoryName;

  const AdsCategoryItem({
    super.key,
    required this.image,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: ColorManager.black),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 7),
            blurRadius: 4,
            spreadRadius: 0,
            color: ColorManager.black.withOpacity(0.25),
          ),
        ],
        image: DecorationImage(image: AssetImage(image),fit: BoxFit.cover)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: CustomElevatedButton(
              backgroundColor: ColorManager.primaryColor,
              isBold: true,
              label: categoryName,
              onPressed: () {},
              width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          Gaps.vGap1,
        ],
      ),
    );
  }
}
