import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_image.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostImagesSlider extends StatelessWidget {
  final List<String> postImages;

  PostImagesSlider({super.key, required this.postImages});

  final dotController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
          ),
          width: MediaQuery.of(context).size.width*0.8,
          height: 300,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: dotController,
            itemCount: postImages.length,
            itemBuilder: (context, index) {
              return GeneralImage.rectangle(
                image: postImages[index],
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                isNetworkImage: false,
                cornerRadius: 30,
              );

            },
          ),
        ),
        if (postImages.isNotEmpty) ...[
          Gaps.vGap2,
          SmoothPageIndicator(
            controller: dotController,
            count: postImages.length,
            effect: ScrollingDotsEffect(
              fixedCenter: true,
              activeDotColor: ColorManager.primaryColor,
              activeStrokeWidth: 5,
              activeDotScale: 0.8,
              maxVisibleDots: 5,
              paintStyle: PaintingStyle.stroke,
              radius: 5,
              spacing: 5,
              dotHeight: 6,
              dotWidth: 6,
              strokeWidth: 1,
              dotColor: ColorManager.disActive.withOpacity(0.5),
            ),
          ),
        ],
      ],
    );
  }
}
