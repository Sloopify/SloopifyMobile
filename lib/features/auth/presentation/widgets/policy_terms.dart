import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';

import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/signup_cubit/sign_up_cubit.dart';

class ConfirmPolicy extends StatefulWidget {
  const ConfirmPolicy({super.key});

  @override
  State<ConfirmPolicy> createState() => _ConfirmPolicyState();
}

class _ConfirmPolicyState extends State<ConfirmPolicy> {
  bool confirm = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_buildCheckBox(), Gaps.hGap1, _buildText(context)],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Text(
          'terms'.tr(),
          style: AppTheme.bodyText3.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCheckBox() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              side: BorderSide(color: ColorManager.primaryColor, width: 2),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              value: state.signupDataEntity.isCheckedTerms,
              onChanged: (value) {
                context.read<SignUpCubit>().setCheckTerms(value!);

              },
            ),
          ),
        );
      },
    );
  }
}
