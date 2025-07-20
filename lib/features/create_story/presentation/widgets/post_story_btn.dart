import 'package:flutter/material.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';

class PostStoryBtn extends StatelessWidget {
  const PostStoryBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: CustomElevatedButton(
        width: MediaQuery.of(context).size.width*0.22,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p8,vertical: 0),
        label: "Post",
        onPressed: () {},
        backgroundColor: ColorManager.primaryColor,
      ),
    );
  }
}
