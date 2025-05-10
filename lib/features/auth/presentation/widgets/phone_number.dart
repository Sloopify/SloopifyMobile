import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/core/utils/app_validators.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/signup_cubit/sign_up_cubit.dart';

class PhoneNumber extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const PhoneNumber({super.key,required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 4, child: _buildCoutryCodePicker()),
        Gaps.hGap1,
        Expanded(
          flex: 12,
          child: CustomTextField(
            hintText: "mobile_number".tr(),
            labelText: "mobile_number2".tr(),
            withTitle: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (value){
              context.read<SignUpCubit>().setMobileNumber(value);
            },
            validator: (value)=>Validator.phoneNumberValidator(value!, context),
          ),
        ),
      ],
    );
  }

  Widget _buildCoutryCodePicker() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.1),
            offset: Offset(0, 2),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
        border: Border.all(color: ColorManager.disActive.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetsManager.country),
          Icon(Icons.keyboard_arrow_down_rounded,color: ColorManager.disActive.withOpacity(0.5),)
        ],
      ),
    );
  }
}
