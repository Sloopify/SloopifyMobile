import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../../../core/managers/assets_managers.dart';
import '../../../../../core/ui/widgets/general_image.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  final _controller = SuperTooltipController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          child: InkWell(
            child: SuperTooltip(
              showBarrier: false,
              controller: _controller,
              right: 20,
              popupDirection: TooltipDirection.up,
              arrowLength: 20,
              backgroundColor: ColorManager.white,
              shadowBlurRadius: 4,
              shadowOffset: Offset(0, 4),
              shadowSpreadRadius: 0,
              borderColor: ColorManager.primaryColor,
              borderWidth: 1.5,
              arrowTipDistance: 25,
              content: InkWell(
                onTap: () {
                  _controller.hideTooltip();
                },
                child: Text(
                  "How are you today?",
                  style: AppTheme.bodyText3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              child: CustomTextField(

                enabled: false,
                onTap: (){},
                hintText: "Daily status",
                withTitle: false,
                onChanged: (value) {},
                keyboardType: TextInputType.text,
              ),
            ),
          ),
        ),
        Gaps.hGap1,
        InkWell(onTap: () {}, child: SvgPicture.asset(AssetsManager.addImage)),
      ],
    );
  }
}
