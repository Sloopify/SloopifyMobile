import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/shimmer_widget.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_intresets_entity.dart';

class InterestsGridItem extends StatelessWidget {
  final UserInterestsEntity userInterestsEntity;
  final bool isSelected;

  const InterestsGridItem({
    super.key,
    required this.userInterestsEntity,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? ColorManager.primaryColor : ColorManager.gray600,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                userInterestsEntity.image,
                height: 60,
                loadingBuilder: (context, child, _) {
                  return ShimmerWidget.rectangular(
                    width: 60,
                    height: 60,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey.shade100,
                  );
                },
                width: 60,
                errorBuilder: (_, __, ___) => Icon(Icons.image),
              ),
              Gaps.hGap1,
              Flexible(
                child: Text(
                  userInterestsEntity.name,
                  style: AppTheme.headline2.copyWith(
                    color: ColorManager.gray600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Gaps.vGap1,
          // Text(
          //   userInterestsEntity.name,
          //   style: AppTheme.headline4.copyWith(
          //     color: ColorManager.gray600,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
        ],
      ),
    );
  }
}
