import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/forget_password_cubit/forget_password_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/welcome_screen.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/managers/theme_manager.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/utils/helper/snackbar.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  static const routeName = "change_password_screen";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        _buildSubmitListener(state, context);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: getCustomAppBar(
            context: context,
            title: "Create new password",
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p40,
                  vertical: AppPadding.p10,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          AssetsManager.writeNewPassword,
                          height: 300,
                        ),
                      ),
                      Gaps.vGap2,
                      Center(
                        child: Text(
                          'Create your new password'.tr(),
                          style: AppTheme.headline4.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      Gaps.vGap3,
                      CustomTextField(
                        initialValue: state.newPassword,
                        labelText: 'Write new password'.tr(),
                        withTitle: true,
                        hintText: "Write new password".tr(),
                        obscureText: true,
                        onChanged: (value) {
                          context.read<ForgetPasswordCubit>().setNewPassword(
                            value,
                          );
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validator:
                            (value) =>
                                Validator.passwordValidate(value!, context),
                      ),
                      Gaps.vGap1,
                      CustomTextField(
                        initialValue: state.confirmNewPassword,
                        labelText: 'confirm_password'.tr(),
                        withTitle: true,
                        hintText: "confirm_password2".tr(),
                        obscureText: true,
                        onChanged: (value) {
                          context
                              .read<ForgetPasswordCubit>()
                              .setConfirmNewPassword(value);
                        },
                        /*icon: Icons.email,*/
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        validator:
                            (value) => Validator.confirmPasswordValidate(
                              value!,
                              state.newPassword,
                              context,
                            ),
                      ),
                      Gaps.vGap8,
                      Center(
                        child: CustomElevatedButton(
                          isLoading:
                              state.submitForgetPasswordStatus ==
                              SubmitForgetPasswordStatus.loading,
                          isBold: true,
                          label: "Change Password".tr(),
                          onPressed:
                              state.submitForgetPasswordStatus ==
                                      SubmitForgetPasswordStatus.loading
                                  ? () {}
                                  : () {
                                    if (!(_formKey.currentState!.validate())) {
                                      return;
                                    }
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .changePassword();
                                  },
                          width: MediaQuery.of(context).size.width * 0.75,
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
    );
  }

  void _buildSubmitListener(ForgetPasswordState state, BuildContext context) {
    if (state.submitForgetPasswordStatus ==
        SubmitForgetPasswordStatus.success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        WelcomeScreen.routeName,
        (route) => false,
      );
    } else if (state.submitForgetPasswordStatus ==
        SubmitForgetPasswordStatus.offline) {
      showSnackBar(context, 'no_internet_connection'.tr());
    } else if (state.submitForgetPasswordStatus ==
        SubmitForgetPasswordStatus.error) {
      showSnackBar(context, state.errorMessage);
    }
  }
}
