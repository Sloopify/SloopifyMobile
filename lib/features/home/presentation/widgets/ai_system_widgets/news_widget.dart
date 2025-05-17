import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.width*0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AssetsManager.homeExample1),
                ),
                borderRadius: BorderRadius.circular(25),
                color: ColorManager.white,
                border: Border.all(color: ColorManager.black),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 7),
                    spreadRadius: 0,
                    blurRadius: 4,
                    color: ColorManager.black.withOpacity(0.25),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 30,
              color: ColorManager.white,
            ),
          ],
        ),
        CustomElevatedButton(
          width: MediaQuery.of(context).size.width*0.5,
          label: "What's News",
          onPressed: () {},
          backgroundColor: ColorManager.primaryColor,
          isBold: true,
        ),
      ],
    );
  }
}
