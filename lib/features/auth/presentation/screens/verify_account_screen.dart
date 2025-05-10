import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart' as sl;
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account/verify_account_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/otp_code_screen.dart';

import '../../../../core/managers/app_dimentions.dart';

class VerifyAccountScreen extends StatelessWidget {
  final bool fromForgetPassword;
  final String? email;
  final String mobileNumber;

  const VerifyAccountScreen({
    super.key,
    this.fromForgetPassword = false,
    this.email = '',
    this.mobileNumber = '',
  });

  static const routeName = "verify_account_screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<VerifyAccountCubit>(),
      child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: getCustomAppBar(
                  context: context, title: 'verify_account'.tr()),
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
                          type: VerifyAccountType.email,
                        ),
                        _buildSelectionTypeOfVerification(
                          type: VerifyAccountType.code,
                          context: context,
                        ),
                        Gaps.vGap3,
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomElevatedButton(
                            label: 'send_code'.tr(),
                            onPressed: () {
                              if (context
                                  .read<VerifyAccountCubit>()
                                  .state
                                  .verifyAccountType == VerifyAccountType.none){
                                return;
                              }else {
                                Navigator
                                  .push(context,MaterialPageRoute(builder: (_)
                              =>
                                  BlocProvider.value(
                                    value: context.read<VerifyAccountCubit>(),
                                    child: OtpCodeScreen(),)
                              ));
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
          }
      ),
    );
  }

  Widget _buildSelectionTypeOfVerification({
    required VerifyAccountType type,
    required BuildContext context,
  }) {
    return BlocBuilder<VerifyAccountCubit, VerifyAccountState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<VerifyAccountCubit>().setVerifyAccountType(type);
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
                state.verifyAccountType != VerifyAccountType.none
                    ? ColorManager.primaryColor
                    : Colors.transparent,
              ),
              color:
              state.verifyAccountType == VerifyAccountType.none
                  ? ColorManager.darkGray
                  : state.verifyAccountType == type
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
                    state.verifyAccountType == VerifyAccountType.none
                        ? ColorManager.disActive.withOpacity(0.5)
                        : state.verifyAccountType == type
                        ? ColorManager.white
                        : ColorManager.disActive.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SvgPicture.asset(
                    type == VerifyAccountType.email
                        ? AssetsManager.email
                        : AssetsManager.sms,
                    color:
                    type == state.verifyAccountType &&
                        state.verifyAccountType !=
                            VerifyAccountType.none
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
                        type == VerifyAccountType.email
                            ? 'via_email'.tr()
                            : 'via_sms'.tr(),
                        style: AppTheme.bodyText3.copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                          state.verifyAccountType == VerifyAccountType.none
                              ? ColorManager.disActive
                              : state.verifyAccountType == type
                              ? ColorManager.white
                              : ColorManager.disActive.withOpacity(0.5),
                        ),
                      ),
                      Gaps.vGap1,
                      Text(
                        type == VerifyAccountType.email
                            ? email??""
                            : mobileNumber??"",
                        style: AppTheme.bodyText3.copyWith(
                          color:
                          state.verifyAccountType == VerifyAccountType.none
                              ? ColorManager.disActive
                              : state.verifyAccountType == type
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
}
