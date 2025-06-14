import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';

class HorizontalPostOption extends StatelessWidget {
  const HorizontalPostOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOption( AssetsManager.photoPost, (){}),
        _buildOption( AssetsManager.postMention, (){}),
        _buildOption( AssetsManager.feelings, (){}),
        _buildOption( AssetsManager.location, (){}),
        _buildOption( AssetsManager.messageOption, (){}),

      ],
    );
  }
  Widget _buildOption( String assetsName, Function() onTap) {
    return InkWell(
      onTap: (){},
      child: SvgPicture.asset(assetsName),
    );
  }
}
