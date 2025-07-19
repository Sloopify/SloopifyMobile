import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/core/utils/app_validators.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/login_with_otp_code/login_with_otp_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/signup_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/write_otp_code_screen.dart';

import '../../../../core/locator/service_locator.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/theme_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../core/utils/helper/snackbar.dart';
import '../widgets/country_code_widget.dart';
import '../widgets/swith_sendotp_type.dart';

class LoginWithOtpCode extends StatefulWidget {
  LoginWithOtpCode({super.key});

  static const routeName = "login_with_code";

  @override
  State<LoginWithOtpCode> createState() => _LoginWithOtpCodeState();
}

class _LoginWithOtpCodeState extends State<LoginWithOtpCode> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController(text: "09");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<LoginWithOtpCubit>(),
      child: BlocConsumer<LoginWithOtpCubit, LoginWithOtpState>(
        listener: (context, state) {
          _buildOtpLoginListener(state, context);
        },
        builder: (context, state) {
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
                          width: MediaQuery.of(context).size.width * 0.7,
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
                        Center(
                          child: Image.asset(
                            AssetsManager.otpCode,
                            height: 250,
                          ),
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
                                        .read<LoginWithOtpCubit>()
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
                                        .read<LoginWithOtpCubit>()
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

                        if (state.otpDataEntity.type == OtpSendType.phone) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "mobile_number".tr(),
                                style: AppTheme.headline4.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                  state.otpDataEntity.phoneNumbers!
                                      .isEmpty
                                      ? ColorManager.disActive
                                      .withOpacity(0.5)
                                      : ColorManager.black,
                                ),
                              ),
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
                                            .read<LoginWithOtpCubit>()
                                            .state
                                            .hasPhoneNumberError
                                            ? 16.0
                                            : 0.0,
                                      ),
                                      child: CountryCodeWidget(
                                        onChangedPhonePrefix: (value){
                                          setState(() {
                                            phoneController.text=value;
                                          });
                                        },
                                        onChanged: (value) {
                                          context
                                              .read<LoginWithOtpCubit>()
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
                                         null,
                                      controller: phoneController,
                                      labelText: 'mobile_number'.tr(),
                                      onChanged: (value) {
                                        context
                                            .read<LoginWithOtpCubit>()
                                            .setPhoneNumber(value);
                                      },
                                      withTitle: false,
                                      hintText: 'mobile_number2'.tr(),
                                      /*icon: Icons.email,*/
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      validator:
                                          (value) {
                                            final err= Validator.phoneNumberValidator(
                                            value!,
                                            context,
                                          );
                                            context.read<LoginWithOtpCubit>().setHasPhoneNumberError(err!=null);
                                            return err;
                                          },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ] else ...[
                          CustomTextField(
                            labelText: 'email'.tr(),
                            initialValue: state.otpDataEntity.email,
                            onChanged: (value) {
                              context.read<LoginWithOtpCubit>().setEmail(value);
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
                        Gaps.vGap3,
                        Center(
                          child: CustomElevatedButton(
                            isLoading:
                                state.otpLoginStatus == OtpLoginStatus.loading,
                            isBold: true,
                            label: "send".tr(),
                            onPressed:
                                state.otpLoginStatus == OtpLoginStatus.loading
                                    ? () {}
                                    : () {
                                      if (!(_formKey.currentState!.validate())) return;
                                      context
                                          .read<LoginWithOtpCubit>()
                                          .otpLogin();
                                    },
                            width: MediaQuery.of(context).size.width * 0.7,
                            backgroundColor: ColorManager.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 10),
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
        },
      ),
    );
  }

  void _buildOtpLoginListener(LoginWithOtpState state, BuildContext context) {
    if (state.otpLoginStatus == OtpLoginStatus.success) {
      Navigator.pushNamed(
        context,
        WriteOtpCodeScreen.routeName,
        arguments: {"otpLoginCubit": context.read<LoginWithOtpCubit>()..startTimer()},
      );
    } else if (state.otpLoginStatus == OtpLoginStatus.offline) {
      showSnackBar(context, 'no_internet_connection'.tr(),isOffline: true);
    } else if (state.otpLoginStatus == OtpLoginStatus.error) {
      showSnackBar(context, state.errorMessage,isError: true);
    }
  }
}
