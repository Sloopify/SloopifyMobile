import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/dialogs/success_dialogs.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/home/presentation/screens/home_navigation_screen.dart';

import '../../../../../core/locator/service_locator.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../../../../core/utils/helper/snackbar.dart';
import '../../blocs/referred_by_cubit/referred_by_cubit.dart';

class ReferredDay extends StatelessWidget {
  ReferredDay({super.key});

  static const routeName = "Referred_day";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => locator<ReferredByCubit>(),
      child: BlocConsumer<ReferredByCubit, ReferredBtyState>(
        listener: (context, state) {
          _buildSubmitListener(context, state);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: getCustomAppBar(
            withArrowBack: false,
              context: context,
              title: "referred_by".tr(),
              centerTitle: true,
            ),
            body: SafeArea(
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
                        Text(
                          "referred_by_hint".tr(),
                          style: AppTheme.headline4.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gaps.vGap3,
                        Center(
                          child: Image.asset(
                            AssetsManager.referredBy,
                            height: 300,
                          ),
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          hintText: "referred_by2".tr(),
                          withTitle: true,
                          labelText: "referred_by".tr(),
                          onChanged: (value) {
                            context.read<ReferredByCubit>().setReferredCode(
                              value,
                            );
                          },
                          validator:
                              (value) =>
                                  Validator.requiredValidate(value!, context),
                        ),
                        Gaps.vGap3,
                        Center(
                          child: CustomElevatedButton(
                            isBold: true,
                            label: "skip".tr(),
                            foregroundColor: ColorManager.primaryColor,
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.symmetric(horizontal: 20),
                                    backgroundColor: ColorManager.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SuccessDialogs(),
                                  );
                                },
                              );
                             await Future.delayed((Duration(seconds: 3)), () {
                                Navigator.of(context).pop();
                              });
                              Navigator.pushNamedAndRemoveUntil(context, HomeNavigationScreen.routeName, (route)=>false);
                            },
                            backgroundColor: ColorManager.white,
                            borderSide: BorderSide(
                              color: ColorManager.primaryColor,
                              width: 1.5,
                            ),
                            width: MediaQuery.of(context).size.width * 0.75,
                          ),
                        ),
                        Gaps.vGap2,
                        Center(
                          child: CustomElevatedButton(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            isBold: true,
                            label: "continue".tr(),
                            isLoading:
                                state.referredByStatus ==
                                SubmitReferredByStatus.loading,
                            onPressed: () {
                              if (!(_formKey.currentState!.validate()) ||
                                  state.referredByStatus ==
                                      SubmitReferredByStatus.loading) {
                                return;
                              } else {
                                context
                                    .read<ReferredByCubit>()
                                    .submitReferredBy();
                              }
                            },
                            backgroundColor: ColorManager.primaryColor,
                            width: MediaQuery.of(context).size.width * 0.75,
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

  Future<void> _buildSubmitListener(BuildContext context, ReferredBtyState state) async {
    if (state.referredByStatus == SubmitReferredByStatus.success) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 30),
            backgroundColor: ColorManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SuccessDialogs(),
          );
        },
      );
   await   Future.delayed((Duration(seconds: 3)), () {
        Navigator.of(context).pop();
      });
      Navigator.pushNamedAndRemoveUntil(context, HomeNavigationScreen.routeName, (route)=>false);
    } else if (state.referredByStatus == SubmitReferredByStatus.offline) {
      showSnackBar(context, "no_internet_connection".tr(),isOffline: true);
    } else if (state.referredByStatus == SubmitReferredByStatus.error) {
      showSnackBar(context, state.errorMessage,isError: true);
    }
  }
}
