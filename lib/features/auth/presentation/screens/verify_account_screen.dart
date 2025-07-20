import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart' as sl;
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/auth_repo.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account/verify_account_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account_by_signup_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/otp_code_screen.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/utils/helper/snackbar.dart';

class VerifyAccountScreen extends StatelessWidget {
  final String? email;
  final String? phoneNumber;
  final bool fromSignUp;

  const VerifyAccountScreen({
    super.key,
    this.email,
    this.phoneNumber,
    this.fromSignUp = false,
  });

  static const routeName = "verify_account_screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<VerifyAccountBySignupCubit>(),
      child: BlocListener<
        VerifyAccountBySignupCubit,
        VerifyAccountBySignupState
      >(
        listener: (context, state) {
          _buildRegisterOtpListener(state, context);
        },
        child: BlocBuilder<
          VerifyAccountBySignupCubit,
          VerifyAccountBySignupState
        >(
          builder: (context, state) {
            return Scaffold(
              appBar: getCustomAppBar(
                context: context,
                title: 'verify_account'.tr(),
                withArrowBack: fromSignUp?true:false,
                onArrowBack: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop(());
                  } else {
                    SystemNavigator.pop();
                  }
                },
              ),
              body: SafeArea(
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
                        Text(
                          'verify_account_type'.tr(),
                          style: AppTheme.headline4.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                        Gaps.vGap3,
                        _buildSelectionTypeOfVerification(
                          context: context,
                          type: OtpSendType.email,
                        ),
                        _buildSelectionTypeOfVerification(
                          type: OtpSendType.phone,
                          context: context,
                        ),
                        Gaps.vGap3,
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomElevatedButton(
                            isLoading:
                                state.otpRegisterStatus ==
                                OtpRegisterStatus.loading,
                            label: 'send_code'.tr(),
                            onPressed:
                                state.otpRegisterStatus ==
                                        OtpRegisterStatus.loading
                                    ? () {}
                                    : () {
                                      if (context
                                              .read<
                                                VerifyAccountBySignupCubit
                                              >()
                                              .state
                                              .otpSendType ==
                                          OtpSendType.none) {
                                        return;
                                      } else {
                                        context
                                            .read<VerifyAccountBySignupCubit>()
                                            .registerOtp(
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
                                                      : "${context.read<AuthRepo>().getUserInfo()?.phoneNumberEntity.code}${context.read<AuthRepo>().getUserInfo()?.phoneNumberEntity.phoneNumber}",
                                            );
                                      }
                                    },
                            backgroundColor: ColorManager.primaryColor,
                            isBold: true,
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

  Widget _buildSelectionTypeOfVerification({
    required OtpSendType type,
    required BuildContext context,
  }) {
    return BlocBuilder<VerifyAccountBySignupCubit, VerifyAccountBySignupState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<VerifyAccountBySignupCubit>().setOtpType(
              type,
              context,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p20,
            ),
            margin: EdgeInsets.symmetric(vertical: AppPadding.p10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color:
                    state.otpSendType != OtpSendType.none
                        ? ColorManager.primaryColor
                        : Colors.transparent,
              ),
              color:
                  state.otpSendType == OtpSendType.none
                      ? ColorManager.darkGray
                      : state.otpSendType == type
                      ? ColorManager.primaryColor
                      : ColorManager.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        state.otpSendType == OtpSendType.none
                            ? ColorManager.disActive.withOpacity(0.5)
                            : state.otpSendType == type
                            ? ColorManager.white
                            : ColorManager.disActive.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SvgPicture.asset(
                    type == OtpSendType.email
                        ? AssetsManager.email
                        : AssetsManager.sms,
                    color:
                        type == state.otpSendType &&
                                state.otpSendType != OtpSendType.none
                            ? ColorManager.primaryColor
                            : ColorManager.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type == OtpSendType.email
                            ? 'via_email'.tr()
                            : 'via_sms'.tr(),
                        style: AppTheme.bodyText3.copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                              state.otpSendType == OtpSendType.none
                                  ? ColorManager.disActive
                                  : state.otpSendType == type
                                  ? ColorManager.white
                                  : ColorManager.disActive.withOpacity(0.5),
                        ),
                      ),
                      Gaps.vGap1,
                      Text(
                        type == OtpSendType.email
                            ? fromSignUp
                                ? email ?? ""
                                : context
                                        .read<AuthRepo>()
                                        .getUserInfo()
                                        ?.email ??
                                    ""
                            : fromSignUp
                            ? phoneNumber ?? ""
                            : context
                                    .read<AuthRepo>()
                                    .getUserInfo()
                                    ?.phoneNumberEntity
                                    .fullNumber ??
                                "",
                        style: AppTheme.bodyText3.copyWith(
                          color:
                              state.otpSendType == OtpSendType.none
                                  ? ColorManager.disActive
                                  : state.otpSendType == type
                                  ? ColorManager.white
                                  : ColorManager.disActive.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _buildRegisterOtpListener(
    VerifyAccountBySignupState state,
    BuildContext context,
  ) {
    if (state.otpRegisterStatus == OtpRegisterStatus.success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: context.read<VerifyAccountBySignupCubit>()..startTimer(),
              child: OtpCodeScreen(fromSignUp:fromSignUp ,phoneNumber: phoneNumber,email: email,),
            );
          },
        ),
      );
    } else if (state.otpRegisterStatus == OtpRegisterStatus.offline) {
      showSnackBar(context, 'no_internet_connection'.tr(),isOffline: true);
    } else if (state.otpRegisterStatus == OtpRegisterStatus.error) {
      showSnackBar(context, state.errorMessage,isError: true);
    }
  }
}
