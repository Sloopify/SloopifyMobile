import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';

import '../../../../core/managers/color_manager.dart';

class WriteOtpCodeScreen extends StatelessWidget {
  const WriteOtpCodeScreen({super.key});

  static const routeName = "write_otc_code_screen";

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AssetsManager.writeOtpCode, height: 300),
                Gaps.vGap2,
                Text(
                  'write_otp_code'.tr(),
                  style: AppTheme.headline2.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 28
                  ),
                ),
                Gaps.vGap2,
                Text(
                  'code_has_sent'.tr(),
                  style: AppTheme.headline4.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gaps.vGap2,

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: PinCodeTextField(
                    errorTextMargin: EdgeInsets.only(top: AppPadding.p4),
                    errorTextSpace: 20,
                    appContext: context,
                    length: 4,
                    blinkWhenObscuring: false,
                    obscureText: false,
                    textStyle: AppTheme.headline4,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      fieldOuterPadding: EdgeInsets.zero,
                      activeColor: ColorManager.black,
                      borderWidth: 0.5,
                      disabledBorderWidth: 0.5,
                      inactiveBorderWidth: 0.5,
                      inactiveColor: ColorManager.disActive.withOpacity(0.5),
                      selectedColor: ColorManager.primaryColor,
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length != 4) {
                        return 'please_enter_correct_pin_code'.tr();
                      } else {
                        return null;
                      }
                    },
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        blurStyle: BlurStyle.normal,
                        offset: Offset(4, 4),
                        color: Colors.black12,
                        blurRadius: AppRadius.r24,
                        spreadRadius: 0,
                      ),
                    ],
                    onCompleted: (v) {},
                    onChanged: (value) {},
                  ),
                ),
                Text(
                  "don't_get_code".tr(),
                  style: AppTheme.headline4.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gaps.vGap2,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'resend_code'.tr(),
                        style: AppTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' 54 ',
                        style: AppTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: 'seconds'.tr(),
                        style: AppTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap4,
                CustomElevatedButton(
                  label: "verify",
                  onPressed: () {
                  },
                  isBold: true,
                  backgroundColor: ColorManager.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
