import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart' as sl;
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/core/utils/helper/toast_utils.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/signup_cubit/sign_up_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/signin_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/verify_account_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/widgets/phone_number.dart';
import 'package:sloopify_mobile/features/auth/presentation/widgets/policy_terms.dart';

import '../../../../core/managers/app_gaps.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/helper/snackbar.dart';
import '../widgets/country_code_widget.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  static const routeName = "signup_screen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<SignUpCubit>(),
      child: Scaffold(
        appBar: getCustomAppBar(context: context),
        body: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            _buildSignUpListener(state, context);
          },
          builder: (context, state) {
            return SafeArea(
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
                            'create_your_account'.tr(),
                            style: AppTheme.headline1.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 32,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        CustomTextField(
                          initialValue: state.signupDataEntity.firstName,
                          labelText: 'first_name'.tr(),
                          onChanged: (value) {
                            context.read<SignUpCubit>().setFirstName(value);
                          },
                          withTitle: true,
                          hintText: 'Nour'.tr(),
                          /*icon: Icons.email,*/
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator:
                              (value) =>
                                  Validator.requiredValidate(value!, context),
                        ),
                        Gaps.vGap1,
                        CustomTextField(
                          initialValue: state.signupDataEntity.lastName,
                          labelText: 'last_name'.tr(),
                          withTitle: true,
                          hintText: "Alkhalil".tr(),
                          onChanged: (value) {
                            context.read<SignUpCubit>().setLastName(value);
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator:
                              (value) =>
                                  Validator.requiredValidate(value!, context),
                        ),
                        Gaps.vGap1,
                        CustomTextField(
                          initialValue: state.signupDataEntity.email,
                          labelText: 'email'.tr(),
                          withTitle: true,
                          hintText: "nour@test2025.com".tr(),
                          onChanged: (value) {
                            context.read<SignUpCubit>().setEmail(value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator:
                              (value) =>
                                  Validator.emailValidator(value!, context),
                        ),
                        Gaps.vGap1,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CountryCodeWidget(
                                onChanged: (value) {
                                  context.read<SignUpCubit>().setCountryCode(
                                    value,
                                  );
                                },
                              ),
                            ),
                            Gaps.hGap2,
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      context
                                              .read<SignUpCubit>()
                                              .state
                                              .hssPhoneNumberError
                                          ? 16.0
                                          : 0.0,
                                ),
                                child: CustomTextField(
                                  initialValue:
                                      state.signupDataEntity.mobileNumber,
                                  labelText: 'mobile_number'.tr(),
                                  onChanged: (value) {
                                    context.read<SignUpCubit>().setMobileNumber(
                                      value,
                                    );
                                  },
                                  withTitle: true,
                                  hintText: '938139179'.tr(),
                                  /*icon: Icons.email,*/
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    final err = Validator.phoneNumberValidator(
                                      value!,
                                      context,
                                    );
                                    context
                                        .read<SignUpCubit>()
                                        .setHasPhoneNumberError(err != null);
                                    return err;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap1,
                        CustomTextField(
                          initialValue: state.signupDataEntity.password,
                          labelText: 'password'.tr(),
                          withTitle: true,
                          hintText: "Password123!".tr(),
                          obscureText: true,
                          onChanged: (value) {
                            context.read<SignUpCubit>().setPassword(value);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          validator:
                              (value) =>
                                  Validator.passwordValidate(value!, context),
                        ),
                        Gaps.vGap1,
                        CustomTextField(
                          initialValue: state.signupDataEntity.confirmPassword,
                          labelText: 'confirm_password'.tr(),
                          withTitle: true,
                          hintText: "Password123!".tr(),
                          obscureText: true,
                          onChanged: (value) {
                            context.read<SignUpCubit>().setConfirmPassword(
                              value,
                            );
                          },
                          /*icon: Icons.email,*/
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          validator:
                              (value) =>
                                  Validator.confirmPasswordValidate(value!, state.signupDataEntity.password,context),
                        ),
                        Gaps.vGap2,
                        ConfirmPolicy(),
                        Gaps.vGap2,
                        Center(
                          child: CustomElevatedButton(
                            isLoading:
                                state.signupStatus == SignupStatus.loading,
                            width: MediaQuery.of(context).size.width * 0.65,
                            label: 'register'.tr(),
                            isBold: true,
                            onPressed:
                                state.signupStatus == SignupStatus.loading
                                    ? () {}
                                    : () {
                                      if (!(_formKey.currentState!.validate()))
                                        return;
                                      if (!state
                                          .signupDataEntity
                                          .isCheckedTerms) {
                                        ToastUtils.showErrorToastMessage(
                                          "please_check_terms".tr(),
                                        );
                                        return;
                                      } else {
                                        context.read<SignUpCubit>().submit();
                                      }
                                    },
                            backgroundColor: ColorManager.primaryColor,
                          ),
                        ),
                        Gaps.vGap2,
                        _buildOrWidget(),
                        Gaps.vGap2,
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "already_have_account".tr(),
                                  style: AppTheme.bodyText3.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${"login".tr()}',
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
                                                  SignInScreen.routeName,
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
            );
          },
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

  void _buildSignUpListener(SignUpState state, BuildContext context) {
    if (state.signupStatus == SignupStatus.done) {
      Navigator.pushNamed(
        context,
        VerifyAccountScreen.routeName,
        arguments: {
          "fromSignUp": true,
          "phoneNumber":state.signupDataEntity.fullPhoneNumber,
          "email":state.signupDataEntity.email
        },
      );
    } else if (state.signupStatus == SignupStatus.noInternet) {
      showSnackBar(context, 'no_internet_connection'.tr());
    } else if (state.signupStatus == SignupStatus.networkError) {
      showSnackBar(context, state.errorMessage);
    }
  }
}
