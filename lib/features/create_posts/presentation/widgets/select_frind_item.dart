import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/general_image.dart';

class SelectFriendItem extends StatefulWidget {
  final UserEntity friendEntity;
  final Function onChanged;
  final bool initValue;

  const SelectFriendItem({
    super.key,
    required this.friendEntity,
    required this.onChanged,
    required this.initValue,
  });

  @override
  State<SelectFriendItem> createState() => _SelectFriendItemState();
}

class _SelectFriendItemState extends State<SelectFriendItem> {
  late bool value;

  @override
  void initState() {
    value = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GeneralImage.circular(
          placeHolder: SvgPicture.asset(AssetsManager.user),
          isNetworkImage: true,
          image: widget.friendEntity.image,
          radius: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorManager.primaryColor, width: 1.5),
          ),
        ),
        Gaps.hGap2,
        Text("${widget.friendEntity.firstName} ${widget.friendEntity.lastName}", style: AppTheme.headline4),
        Spacer(),
        SizedBox(
          width: 18,
          height: 18,
          child: Checkbox(
            value: value, activeColor:ColorManager.primaryColor ,

            onChanged: (v) {
              setState(() {
              value=v!;
              });
              widget.onChanged(value);
            },
            side: BorderSide(
              width: AppSize.s2,
              color: ColorManager.primaryColor,
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r12),
              side: BorderSide(color: ColorManager.primaryColor)
            ),
          ),
        ),
      ],
    );
  }
}
