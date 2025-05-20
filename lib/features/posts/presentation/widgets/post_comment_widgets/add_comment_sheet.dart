import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';

class AddCommentSheet extends StatelessWidget {
  const AddCommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.12,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: ColorManager.black.withOpacity(0.25)
          ),
        ]
      ),
      child: CustomTextField(hintText: ""),
    );
  }
}
