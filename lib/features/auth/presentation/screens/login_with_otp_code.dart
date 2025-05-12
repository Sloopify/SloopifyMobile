
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/core/utils/app_validators.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/signup_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/write_otp_code_screen.dart';

import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/theme_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';

class LoginWithOtpCode extends StatelessWidget {
   LoginWithOtpCode({super.key});
  final _formKey = GlobalKey<FormState>();

  static const routeName ="login_with_code";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p30,
              vertical: AppPadding.p10,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'login_with_otp_code'.tr(),
                      style: AppTheme.headline1.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Gaps.vGap2,
                  Center(child: Image.asset(AssetsManager.otpCode, height: 300)),
                  Gaps.vGap1,
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
                  Gaps.vGap3,
                  Center(
                    child: CustomElevatedButton(
                      isBold: true,
                      label: "send".tr(),
                      onPressed: () {
                        if(!(_formKey.currentState!.validate())) return;
                        Navigator.pushNamed(context, WriteOtpCodeScreen.routeName);
                      },
                      width: MediaQuery.of(context).size.width * 0.7,
                      backgroundColor: ColorManager.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
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
                                  () =>
                                  Navigator.pushReplacementNamed(
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
}
