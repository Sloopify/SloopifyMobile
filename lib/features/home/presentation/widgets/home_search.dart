import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';

import '../../../../../core/managers/assets_managers.dart';
import '../../../../../core/ui/widgets/general_image.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GeneralImage.circular(
          radius: 50,
          isNetworkImage: false,
          image: AssetsManager.homeExample3,
          fit: BoxFit.cover,
        ),
        Gaps.hGap1,
        Expanded(
          child: CustomTextField(
            hintText: "Daily status",
            withTitle: false,
            onChanged: (value) {},
            keyboardType: TextInputType.text,
          ),
        ),
        Gaps.hGap1,
        InkWell(
          onTap: (){},
          child: SvgPicture.asset(AssetsManager.addImage),
        )
      ],
    );
  }
}
