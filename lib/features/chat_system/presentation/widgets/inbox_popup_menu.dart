import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/screens/chat_settings.dart';

class InboxPopupMenu extends StatelessWidget {
  const InboxPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: ColorManager.white,
      surfaceTintColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(color: ColorManager.disActive.withOpacity(0.5)),
      ),
      position: PopupMenuPosition.under,
      borderRadius: BorderRadius.circular(25),
      elevation: 10,
      shadowColor: ColorManager.black.withOpacity(0.25),
      offset: Offset(-20, 0),
      icon: SvgPicture.asset(AssetsManager.inboxInfo),
      onSelected: (String option) {
        if(option=="Settings"){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatSettings()));
        }
      },
      itemBuilder:
          (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'New Group',
              child: Row(
                children: [
                  SvgPicture.asset(AssetsManager.newGroup),
                  Gaps.hGap1,
                  Text(
                    'New Group',
                    style: AppTheme.bodyText3.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'Mark all as read',
              child: Row(
                children: [
                  SvgPicture.asset(AssetsManager.makeAsRead),
                  Gaps.hGap1,
                  Text(
                    'Mark all as read',
                    style: AppTheme.bodyText3.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'Starred messages',
              child: Row(
                children: [
                  SvgPicture.asset(AssetsManager.starredMessage),
                  Gaps.hGap1,
                  Text(
                    'Starred messages',
                    style: AppTheme.bodyText3.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'Settings',
              child: Row(
                children: [
                  SvgPicture.asset(AssetsManager.settingChat),
                  Gaps.hGap1,
                  Text(
                    'Settings',
                    style: AppTheme.bodyText3.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
    );
  }
}
