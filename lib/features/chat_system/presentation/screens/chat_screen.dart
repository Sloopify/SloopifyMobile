import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';

import '../../../../core/managers/app_dimentions.dart';

class ChatScreen extends StatelessWidget {
  final String senderName;

  const ChatScreen({super.key, required this.senderName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: senderName,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
            child: SvgPicture.asset(AssetsManager.inboxInfo),
          ),
          Gaps.hGap1,
          SvgPicture.asset(AssetsManager.call),
          Gaps.hGap1,
          SvgPicture.asset(AssetsManager.videoCall),
        ],
      ),
      body: SafeArea(child: SingleChildScrollView(

      )),
    );
  }
}
