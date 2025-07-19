import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/app_wrapper/presentation/screens/app_wrapper.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/auth_repo.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account_by_signup_cubit.dart';

import '../../../../core/utils/helper/snackbar.dart';

class OtpCodeScreen extends StatelessWidget {
  final String? email;
  final String? phoneNumber;
  final bool fromSignUp;

  const OtpCodeScreen({
    super.key,
    this.phoneNumber,
    this.email,
    this.fromSignUp = false,
  });

  static const routeName = "otp_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context),
      body: BlocConsumer<
          VerifyAccountBySignupCubit,
          VerifyAccountBySignupState
      >(
        listener: (context, state) {
          _buildVerifyCodeListener(state, context);
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
                      'Verify code',
                      style: AppTheme.headline1.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.vGap1,
                    Text(
                      'Code has been sent to your ${state.otpSendType ==
                          OtpSendType.phone ? 'phone number' : "E-mail"}',
                      style: AppTheme.bodyText3.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gaps.vGap1,
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
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
                        autovalidateMode: AutovalidateMode.onUnfocus,
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
                          context.read<VerifyAccountBySignupCubit>().setOtpCode(
                            v,
                          );
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
                    if (!state.isTimerFinished) ...[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Resend code in ',
                              style: AppTheme.headline4.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: formatDuration(state.timerSeconds),
                              style: AppTheme.headline4.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorManager.primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' m',
                              style: AppTheme.headline4.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else
                      ...[
                        InkWell(
                          onTap: state.otpRegisterStatus==OtpRegisterStatus.init?() {
                            if (state.isTimerFinished) {
                              context
                                  .read<VerifyAccountBySignupCubit>()
                                  .registerOtp(
                                fromReset: true,
                                email:
                                fromSignUp
                                    ? email ?? ""
                                    : context
                                    .read<AuthRepo>()
                                    .getUserInfo()
                                    ?.email ??
                                    "",

                                phoneNumber:
                                fromSignUp
                                    ? phoneNumber ?? ""
                                    : "${context
                                    .read<AuthRepo>()
                                    .getUserInfo()
                                    ?.phoneNumberEntity
                                    .code}${context
                                    .read<AuthRepo>()
                                    .getUserInfo()
                                    ?.phoneNumberEntity
                                    .phoneNumber}",
                              );
                            }
                          }:(){},
                          child:  Text(
                            state.otpRegisterStatus == OtpRegisterStatus.loading
                                ? "Re-sending code..."
                                : state.otpRegisterStatus == OtpRegisterStatus.init
                                ? "Resend code"
                                : "",
                            style: AppTheme.headline4.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                      ],
                    Gaps.vGap4,
                    InkWell(
                      onTap:
                      state.verifyRegisterOtpStatus ==
                          VerifyRegisterOtpStatus.loading
                          ? () {}
                          : () {
                        if (state.verifyOtpEntity.otp.length != 6) {
                          return;
                        } else {
                          context
                              .read<VerifyAccountBySignupCubit>()
                              .verifyOtpLogin(
                            email:
                            fromSignUp
                                ? email ?? ""
                                : context
                                .read<AuthRepo>()
                                .getUserInfo()
                                ?.email ??
                                "",
                            phoneNumber:
                            fromSignUp
                                ? phoneNumber ?? ""
                                : "${context
                                .read<AuthRepo>()
                                .getUserInfo()
                                ?.phoneNumberEntity
                                .code}${context
                                .read<AuthRepo>()
                                .getUserInfo()
                                ?.phoneNumberEntity
                                .phoneNumber}",
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                          state.verifyOtpEntity.otp.length != 6
                              ? ColorManager.disActive.withOpacity(0.3)
                              : ColorManager.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              color: ColorManager.black.withOpacity(0.2),
                              blurRadius: 4,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child:
                        state.verifyRegisterOtpStatus ==
                            VerifyRegisterOtpStatus.loading
                            ? FittedBox(
                              child: CircularProgressIndicator(
                                                        color: ColorManager.white,
                                                      ),
                            )
                            : FittedBox(
                              child: Text(
                                                        "verify",
                                                        style: AppTheme.headline4.copyWith(
                              color: ColorManager.white,
                              fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                            ),
                      ),
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

  void _buildVerifyCodeListener(VerifyAccountBySignupState state,
      BuildContext context,) {
    if (state.verifyRegisterOtpStatus == VerifyRegisterOtpStatus.success) {
      showSnackBar(
        context,
        "You have registered successfully,now please login it to complete your account information",
      );
      context.read<AuthenticationBloc>().add(UpdateEvent());
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppWrapper.routeName,
            (route) => false,
      );
    } else if (state.verifyRegisterOtpStatus ==
        VerifyRegisterOtpStatus.offline) {
      showSnackBar(context, 'no_internet_connection'.tr(), isOffline: true);
    } else if (state.verifyRegisterOtpStatus == VerifyRegisterOtpStatus.error) {
      showSnackBar(context, state.errorMessage, isError: true);
    }
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }
}
