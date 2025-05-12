import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/user_interests.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/login_with_otp_code.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/signup_screen.dart';

import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/theme_manager.dart';
import '../../../../core/utils/app_validators.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  static const routeName = "sign_in_screen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p30,
              vertical: AppPadding.p20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'login_to_your_account'.tr(),
                      style: AppTheme.headline1.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Gaps.vGap3,
                  CustomTextField(
                    labelText: 'email_or_mobile'.tr(),
                    onChanged: (value) {},
                    withTitle: true,
                    hintText: 'email_or_mobile2'.tr(),
                    /*icon: Icons.email,*/
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator:
                        (value) => Validator.requiredValidate(value!, context),
                  ),
                  Gaps.vGap2,
                  CustomTextField(
                    obscureText: true,
                    labelText: 'password'.tr(),
                    withTitle: true,
                    hintText: "password2".tr(),
                    onChanged: (value) {},
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator:
                        (value) => Validator.passwordValidate(value!, context),
                  ),
                  Gaps.vGap2,
                  _buildRememberMe(),
                  Gaps.vGap2,
                  Center(
                    child: CustomElevatedButton(
                      isBold: true,
                      label: "login".tr(),
                      onPressed: () {
                        //  if(!(_formKey.currentState!.validate()))return;
                        Navigator.pushNamed(context, UserInterests.routeName);
                      },
                      width: MediaQuery.of(context).size.width * 0.7,
                      backgroundColor: ColorManager.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                  Gaps.vGap2,
                  Center(
                    child: Text(
                      'forget_password'.tr(),
                      style: AppTheme.headline3.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  ),
                  Gaps.vGap2,
                  _buildOrWidget(),
                  Gaps.vGap2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomElevatedButton(
                        padding: EdgeInsets.all(10),
                        width: 50,
                        svgPic: SvgPicture.asset(AssetsManager.google),
                        label: "",
                        onPressed: () {},
                        backgroundColor: ColorManager.white,
                        borderSide: BorderSide(
                          color: ColorManager.primaryColor,
                        ),
                      ),
                      CustomElevatedButton(
                        padding: EdgeInsets.all(10),
                        width: 50,
                        svgPic: SvgPicture.asset(AssetsManager.apple),
                        label: "",
                        onPressed: () {},
                        backgroundColor: ColorManager.white,
                        borderSide: BorderSide(
                          color: ColorManager.primaryColor,
                        ),
                      ),
                      CustomElevatedButton(
                        padding: EdgeInsets.all(10),
                        width: 50,
                        svgPic: SvgPicture.asset(AssetsManager.otp),
                        label: "",
                        onPressed:
                            () => Navigator.pushNamed(
                              context,
                              LoginWithOtpCode.routeName,
                            ),
                        backgroundColor: ColorManager.white,
                        borderSide: BorderSide(
                          color: ColorManager.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap3,
                  Center(
                    child: RichText(
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
                                      () => Navigator.pushReplacementNamed(
                                        context,
                                        SignupScreen.routeName,
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            side: BorderSide(color: ColorManager.primaryColor, width: 2),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            value: false,
            onChanged: (value) {},
          ),
        ),
        Gaps.hGap1,
        Text(
          'remember_me'.tr(),
          style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
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
            indent: 30,
          ),
        ),
        Text(
          'or'.tr(),
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
            endIndent: 30,
            indent: 30,
          ),
        ),
      ],
    );
  }
}
