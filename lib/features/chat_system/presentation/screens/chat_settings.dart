import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';

import '../../../../core/managers/app_dimentions.dart';

class ChatSettings extends StatelessWidget {
  const ChatSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: "settings",
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSettingItem(
                  text: "Privacy",
                  assets: AssetsManager.privacy,
                  onTap: () {},
                ),
                Gaps.vGap4,
                _buildSettingItem(
                  text: "Notification",
                  assets: AssetsManager.chatNotification,
                  onTap: () {},
                ),
                Gaps.vGap4,
                _buildSettingItem(
                  text: "Chat",
                  assets: AssetsManager.chat,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String text,
    required String assets,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(assets),
          Gaps.hGap3,
          Text(
            text,
            style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
