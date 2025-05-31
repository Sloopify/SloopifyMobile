import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/local_storage/preferene_utils.dart';
import 'package:sloopify_mobile/core/local_storage/prefernces_key.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:ui' as ui;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = 'onBoarding_screen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = index == 2;
                });
              },
              children: [
                buildPage(
                  title: 'welcome1'.tr(),
                  content: 'welcome_hint1'.tr(),
                  image: AssetsManager.welcome1, // ضع هنا الصورة المطلوبة
                ),
                buildPage(
                  title: 'welcome2'.tr(),
                  content: 'welcome_hint2'.tr(),
                  image: AssetsManager.welcome2,
                ),
                buildPage(
                  title: 'welcome3'.tr(),
                  content: 'welcome_hint3'.tr(),
                  image: AssetsManager.welcome3,
                ),
              ],
            ),
            Positioned.directional(
              textDirection: ui.TextDirection.ltr,
              bottom: 200,
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 12,
                  expansionFactor: 2,
                  dotColor: ColorManager.lightGray,
                  activeDotColor: ColorManager.primaryColor,
                ),
              ),
            ),
            Positioned(
            bottom: 50,
              child: Row(
                children: [
                  CustomElevatedButton(
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.7,
                    label: onLastPage ? 'filled_btn'.tr() : 'next'.tr(),
                    onPressed: () async {
                      if (onLastPage) {
                        await PreferenceUtils.setBool(SharedPrefsKey.firstTime, true);
                        Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
                      } else {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    backgroundColor: ColorManager.primaryColor,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () async {
                 await PreferenceUtils.setBool(SharedPrefsKey.firstTime, true);
                 Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
                },
                child: Text(
                  'skip'.tr(),
                  style: AppTheme.bodyText3.copyWith(
                    color: ColorManager.textGray,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required String title,
    required String content,
    required String image,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p40,
        vertical: AppPadding.p20,
      ),
      child: Column(
        children: [
          Gaps.vGap12,
          Image.asset(image, height: 200),
         Gaps.vGap5,
          Text(
            title,
            style: AppTheme.headline3.copyWith(fontWeight: FontWeight.bold),
          ),
          Gaps.vGap3,
          Text(
            content,
            textAlign: TextAlign.center,
            style: AppTheme.bodyText3.copyWith(
              color: ColorManager.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
