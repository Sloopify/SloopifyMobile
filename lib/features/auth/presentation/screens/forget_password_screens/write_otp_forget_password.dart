import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/forget_password_cubit/forget_password_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/forget_password_screens/change_pawword_screen.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/managers/assets_managers.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/managers/theme_manager.dart';
import '../../../../../core/ui/widgets/custom_app_bar.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/utils/helper/snackbar.dart';
import '../../../domain/entities/otp_data_entity.dart';

class WriteOtpForgetPassword extends StatelessWidget {
  const WriteOtpForgetPassword({super.key});
  static const routeName="write_otp_forget_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context,title: "Forgot Password",),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          _buildRegisterOtpListener(state, context);
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p40,
                  vertical: AppPadding.p10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetsManager.verifyAccount, height: 300),
                    Gaps.vGap2,
                    Text(
                      'Code has been sent to your ${state.otpDataEntity.type == OtpSendType.phone ? 'phone number' : "E-mail"}',
                      style: AppTheme.bodyText3.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gaps.vGap1,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: PinCodeTextField(
                        errorTextMargin: EdgeInsets.only(top: AppPadding.p4),
                        errorTextSpace: 20,
                        appContext: context,
                        length: 6,
                        blinkWhenObscuring: false,
                        obscureText: false,
                        textStyle: AppTheme.headline4,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 45,
                          fieldWidth: 45,
                          activeFillColor: Colors.white,
                          fieldOuterPadding: EdgeInsets.zero,
                          activeColor: ColorManager.black,
                          borderWidth: 0.5,
                          disabledBorderWidth: 0.5,
                          inactiveBorderWidth: 0.5,
                          inactiveColor: ColorManager.disActive.withOpacity(
                            0.5,
                          ),
                          selectedColor: ColorManager.primaryColor,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length != 6) {
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
                        onCompleted: (v) {
                          context.read<ForgetPasswordCubit>().setOtpCode(v);
                        },
                        onChanged: (value) {},
                      ),
                    ),
                    Text(
                      'Don’t get the code?',
                      style: AppTheme.headline4.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gaps.vGap2,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Resend code in',
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
                            text: 's',
                            style: AppTheme.headline4.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap8,
                    CustomElevatedButton(
                      isLoading:
                      state.verifyOtpStatus ==
                          VerifyOtpStatus.loading,
                      label: "verify",
                      onPressed:
                      state.verifyOtpStatus ==
                          VerifyOtpStatus.loading
                          ? () {}
                          : () {
                        context.read<ForgetPasswordCubit>().verifyOtpLogin();
                      },
                      isBold: true,
                      backgroundColor: ColorManager.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _buildRegisterOtpListener(ForgetPasswordState state, BuildContext context) {
    if (state.verifyOtpStatus == VerifyOtpStatus.success) {
      Navigator.pushNamed(
        context,
        ChangePasswordScreen.routeName,
        arguments: {"forgetPasswordCubit": context.read<ForgetPasswordCubit>()},
      );
    } else if (state.verifyOtpStatus == VerifyOtpStatus.offline) {
      showSnackBar(context, 'no_internet_connection'.tr());
    } else if (state.verifyOtpStatus == VerifyOtpStatus.error) {
      showSnackBar(context, state.errorMessage);
    }
  }
}
