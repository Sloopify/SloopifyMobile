import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_data_entity.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/user_interests.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/login_with_otp_code.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/signup_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/verify_account_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/widgets/country_code_widget.dart';
import 'package:sloopify_mobile/features/auth/presentation/widgets/switch_login_type.dart';
import 'package:sloopify_mobile/features/home/presentation/blocs/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:sloopify_mobile/features/home/presentation/screens/home_navigation_screen.dart';

import '../../../../core/locator/service_locator.dart' as sl;
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/theme_manager.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/helper/snackbar.dart';
import '../../../app_wrapper/presentation/screens/app_wrapper.dart';
import '../blocs/authentication_bloc/authentication_bloc.dart';
import 'forget_password_screens/otp_forget_password.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  static const routeName = "sign_in_screen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<LoginCubit>(),
      child: Scaffold(
        appBar: getCustomAppBar(context: context),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            _buildLoginListener(state, context);
          },
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return SafeArea(
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
                                border: Border.all(
                                  color: ColorManager.darkGray,
                                ),
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
                                  SwitchLoginType(
                                    onChanged: () {
                                      context.read<LoginCubit>().setLoginType(
                                        LoginType.email,
                                      );
                                    },
                                    loginType: LoginType.email,
                                    isSelected:
                                        context
                                            .read<LoginCubit>()
                                            .state
                                            .loginDataEntity
                                            .loginType ==
                                        LoginType.email,
                                  ),
                                  SwitchLoginType(
                                    onChanged: () {
                                      context.read<LoginCubit>().setLoginType(
                                        LoginType.phoneNumber,
                                      );
                                    },
                                    loginType: LoginType.phoneNumber,
                                    isSelected:
                                        context
                                            .read<LoginCubit>()
                                            .state
                                            .loginDataEntity
                                            .loginType ==
                                        LoginType.phoneNumber,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (state.loginDataEntity.loginType ==
                              LoginType.phoneNumber) ...[
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
                                                  .read<LoginCubit>()
                                                  .state
                                                  .phoneNumberHasError
                                              ? 16.0
                                              : 0.0,
                                    ),
                                    child: CountryCodeWidget(
                                      onChanged: (value) {
                                        context.read<LoginCubit>().setDialCode(
                                          value,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Gaps.hGap2,
                                Expanded(
                                  flex: 3,
                                  child: CustomTextField(
                                    initialValue:
                                        state.loginDataEntity.phoneNumber,
                                    labelText: 'mobile_number'.tr(),
                                    onChanged: (value) {
                                      context.read<LoginCubit>().setPhoneNumber(
                                        value,
                                      );
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
                                          .read<LoginCubit>()
                                          .setPhoneNumberValidator(err != null);
                                      return err;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ] else ...[
                            CustomTextField(
                              initialValue: state.loginDataEntity.email,
                              labelText: 'email'.tr(),
                              onChanged: (value) {
                                context.read<LoginCubit>().setEmail(value);
                              },
                              withTitle: true,
                              hintText: 'email'.tr(),
                              /*icon: Icons.email,*/
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator:
                                  (value) =>
                                      Validator.emailValidator(value!, context),
                            ),
                          ],

                          Gaps.vGap2,
                          CustomTextField(
                            initialValue: state.loginDataEntity.password,
                            obscureText: true,
                            labelText: 'password'.tr(),
                            withTitle: true,
                            hintText: "password2".tr(),
                            onChanged: (value) {
                              context.read<LoginCubit>().setPassword(value);
                            },
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            validator:
                                (value) =>
                                    Validator.passwordValidate(value!, context),
                          ),
                          Gaps.vGap2,
                          // _buildRememberMe(),
                          //  Gaps.vGap2,
                          Center(
                            child: CustomElevatedButton(
                              isBold: true,
                              isLoading:
                                  state.loginStatus == LoginStatus.loading,
                              label: "login".tr(),
                              onPressed:
                                  state.loginStatus == LoginStatus.loading
                                      ? () {}
                                      : () {
                                        if (!(_formKey.currentState!
                                            .validate())) {
                                          return;
                                        }
                                        if (state.loginDataEntity.loginType ==
                                            LoginType.email) {
                                          context
                                              .read<LoginCubit>()
                                              .loginWithEmail();
                                        } else {
                                          context
                                              .read<LoginCubit>()
                                              .loginWithPhone();
                                        }
                                      },
                              width: MediaQuery.of(context).size.width * 0.7,
                              backgroundColor: ColorManager.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                          Gaps.vGap2,
                          Center(
                            child: InkWell(
                              onTap: (){
                                Navigator.pushNamed(
                                  context,
                                  OtpForgetPassword.routeName,
                                );
                              },
                              child: Text(
                                'forget_password'.tr(),
                                style: AppTheme.headline3.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorManager.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          Gaps.vGap2,
                          _buildOrWidget(),
                          Gaps.vGap2,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSocialMediaBtn(
                                assets: AssetsManager.google,
                                onTap: () {},
                              ),
                              _buildSocialMediaBtn(
                                assets: AssetsManager.apple,
                                onTap: () {},
                              ),
                              _buildSocialMediaBtn(
                                assets: AssetsManager.otp,
                                onTap: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(LoginWithOtpCode.routeName);
                                },
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
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget _buildRememberMe() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SizedBox(
  //         width: 24,
  //         height: 24,
  //         child: Checkbox(
  //           side: BorderSide(color: ColorManager.primaryColor, width: 2),
  //           shape: ContinuousRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           value: false,
  //           onChanged: (value) {},
  //         ),
  //       ),
  //       Gaps.hGap1,
  //       Text(
  //         'remember_me'.tr(),
  //         style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
  //       ),
  //     ],
  //   );
  // }

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

  void _buildLoginListener(LoginState state, BuildContext context) {
    if (state.loginStatus == LoginStatus.done) {
      BlocProvider.of<AuthenticationBloc>(context).add(UpdateEvent());
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppWrapper.routeName,
        (route) => false,
      );
    } else if (state.loginStatus == LoginStatus.noInternet) {
      showSnackBar(context, 'no_internet_connection'.tr(),isOffline: true);
    } else if (state.loginStatus == LoginStatus.networkError) {
      showSnackBar(context, state.errorMessage,isError: true);
    }
  }

  Widget _buildSocialMediaBtn({
    required String assets,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              color: ColorManager.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
        ),
        child: SvgPicture.asset(assets),
      ),
    );
  }
}
