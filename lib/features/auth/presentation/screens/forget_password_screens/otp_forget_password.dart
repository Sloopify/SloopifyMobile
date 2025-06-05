import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/forget_password_cubit/forget_password_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/forget_password_screens/write_otp_forget_password.dart';

import '../../../../../core/locator/service_locator.dart';
import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/managers/assets_managers.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/managers/theme_manager.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/utils/helper/snackbar.dart';
import '../../../domain/entities/otp_data_entity.dart';
import '../../widgets/country_code_widget.dart';
import '../../widgets/swith_sendotp_type.dart';

class OtpForgetPassword extends StatelessWidget {
  OtpForgetPassword({super.key});

  final _formKey = GlobalKey<FormState>();
  static const routeName = "otp_forget_password";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ForgetPasswordCubit>(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          _buildOtpListener(state, context);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: getCustomAppBar(
              context: context,
              title: "Forgot Password",
              centerTitle: false,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p20,
                    vertical: AppPadding.p10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AssetsManager.forgetPassword, height: 200),
                        Text(
                          'Select which contact details should we use to reset your password'
                              .tr(),
                          style: AppTheme.headline4.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        Gaps.vGap1,
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: AppPadding.p20,
                            ),
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorManager.white,
                              border: Border.all(color: ColorManager.darkGray),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.black.withOpacity(0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SwitchSendOtpType(
                                  onChanged: () {
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .setLoginType(OtpSendType.email);
                                  },
                                  otpSendType: OtpSendType.email,
                                  isSelected:
                                      state.otpDataEntity.type ==
                                      OtpSendType.email,
                                ),
                                SwitchSendOtpType(
                                  onChanged: () {
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .setLoginType(OtpSendType.phone);
                                  },
                                  otpSendType: OtpSendType.phone,
                                  isSelected:
                                      state.otpDataEntity.type ==
                                      OtpSendType.phone,
                                ),

                              ],
                            ),
                          ),
                        ),
                        if (state.otpDataEntity.type ==
                            OtpSendType.phone) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                    context
                                        .read<
                                        ForgetPasswordCubit
                                    >()
                                        .state
                                        .hasPhoneNumberError
                                        ? 16.0
                                        : 0.0,
                                  ),
                                  child: CountryCodeWidget(
                                    onChanged: (value) {
                                      context
                                          .read<ForgetPasswordCubit>()
                                          .setDialCode(value);
                                    },
                                  ),
                                ),
                              ),
                              Gaps.hGap2,
                              Expanded(
                                flex: 3,
                                child: CustomTextField(
                                  initialValue:
                                  state.otpDataEntity.phoneNumbers,
                                  labelText: 'mobile_number'.tr(),
                                  onChanged: (value) {
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .setPhoneNumber(value);
                                  },
                                  withTitle: true,
                                  hintText: 'mobile_number2'.tr(),
                                  /*icon: Icons.email,*/
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    final err =
                                    Validator.phoneNumberValidator(
                                      value!,
                                      context,
                                    );
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .setHasPhoneNumberError(
                                      err != null,
                                    );
                                    return err;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          CustomTextField(
                            labelText: 'email'.tr(),
                            initialValue: state.otpDataEntity.email,
                            onChanged: (value) {
                              context
                                  .read<ForgetPasswordCubit>()
                                  .setEmail(value);
                            },
                            withTitle: true,
                            hintText: 'email'.tr(),
                            /*icon: Icons.email,*/
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator:
                                (value) => Validator.emailValidator(
                              value!,
                              context,
                            ),
                          ),
                        ],
                        Gaps.vGap12,
                        Center(
                          child: CustomElevatedButton(
                            isLoading:
                            state.otpSendStatus ==
                                OtpSendStatus.loading,
                            isBold: true,
                            label: "send Code".tr(),
                            onPressed:
                            state.otpSendStatus ==
                                OtpSendStatus.loading
                                ? () {}
                                : () {
                              if (!(_formKey.currentState!
                                  .validate())) {
                                return;
                              }
                              context
                                  .read<ForgetPasswordCubit>()
                                  .requestOtp();
                            },
                            width:
                            MediaQuery.of(context).size.width * 0.7,
                            backgroundColor: ColorManager.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _buildOtpListener(ForgetPasswordState state, BuildContext context) {
    if (state.otpSendStatus == OtpSendStatus.success) {
      Navigator.pushNamed(
        context,
        WriteOtpForgetPassword.routeName,
        arguments: {"forgetPasswordCubit": context.read<ForgetPasswordCubit>()},
      );
    } else if (state.otpSendStatus == OtpSendStatus.offline) {
      showSnackBar(context, 'no_internet_connection'.tr());
    } else if (state.otpSendStatus == OtpSendStatus.error) {
      showSnackBar(context, state.errorMessage);
    }
  }
}
