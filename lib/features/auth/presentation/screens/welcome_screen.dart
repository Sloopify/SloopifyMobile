import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/signin_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/signup_screen.dart';

import '../../../../core/managers/app_gaps.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const routeName = "welcome_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.vGap3,
              Center(child: Image.asset(AssetsManager.startUp, height: 300)),
              Gaps.vGap2,
              Text(
                'let_you_in'.tr(),
                style: AppTheme.headline1.copyWith(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              Gaps.vGap4,
              CustomElevatedButton(
                isBold: true,
                svgAlignment: IconAlignment.start,
                svgPic: SvgPicture.asset(AssetsManager.google),
                width: MediaQuery.of(context).size.width * 0.7,
                label: 'continue_with_google'.tr(),
                onPressed: () {},
                backgroundColor: ColorManager.white,
                foregroundColor: ColorManager.primaryColor,
                borderSide: BorderSide(color: ColorManager.primaryColor),
              ),
              Gaps.vGap1,
              CustomElevatedButton(
                isBold: true,
                svgAlignment: IconAlignment.start,
                svgPic: SvgPicture.asset(AssetsManager.apple),
                width: MediaQuery.of(context).size.width * 0.7,
                label: 'continue_with_apple'.tr(),
                onPressed: () {},
                backgroundColor: ColorManager.white,
                foregroundColor: ColorManager.primaryColor,
                borderSide: BorderSide(color: ColorManager.primaryColor),
              ),
              Gaps.vGap2,
              _buildOrWidget(),
              Gaps.vGap2,
              CustomElevatedButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width * 0.7,
                label: 'login'.tr(),
                onPressed: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                backgroundColor: ColorManager.primaryColor,
              ),
              Gaps.vGap2,
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "don't_have_account".tr(),
                      style: AppTheme.bodyText3.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: ' ${"signup".tr()}',
                      style: AppTheme.bodyText3.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorManager.primaryColor,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap =
                                () => Navigator.pushNamed(
                                  context,
                                  SignupScreen.routeName,
                                ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrWidget() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: ColorManager.black,
            thickness: 1,
            endIndent: 30,
            indent: 55,
          ),
        ),
        Text(
          'or',
          style: AppTheme.headline4.copyWith(
            fontSize: 18,
            color: ColorManager.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            color: ColorManager.black,
            thickness: 1,
            endIndent: 55,
            indent: 30,
          ),
        ),
      ],
    );
  }
}
