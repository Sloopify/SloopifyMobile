import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/dialogs/success_dialogs.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';

import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/ui/widgets/custom_text_field.dart';
import '../../../../../core/utils/app_validators.dart';
import '../../blocs/account_info/profile_info_cubit.dart';

class ReferredDay extends StatelessWidget {
  const ReferredDay({super.key});

  static const routeName = "Referred_day";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: "referred_by".tr(),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Icon(Icons.arrow_forward, color: ColorManager.black),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p30,
              vertical: AppPadding.p20,
            ),
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
                  child: Image.asset(AssetsManager.referredBy, height: 300),
                ),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  hintText: "referred_by2".tr(),
                  withTitle: true,
                  labelText: "referred_by".tr(),
                  onChanged: (value) {
                    context.read<ProfileInfoCubit>().setLocation(value);
                  },
                  validator:
                      (value) => Validator.requiredValidate(value!, context),
                ),
                Gaps.vGap3,
                Center(
                  child: CustomElevatedButton(
                    isBold: true,
                    label: "skip".tr(),
                    foregroundColor: ColorManager.primaryColor,
                    onPressed: () {},
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return Dialog(insetPadding: EdgeInsets.symmetric(horizontal: 30),
                            backgroundColor: ColorManager.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SuccessDialogs(),
                          );
                        },
                      );
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
    );
  }
}
