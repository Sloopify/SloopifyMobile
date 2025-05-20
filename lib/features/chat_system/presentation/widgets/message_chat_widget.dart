import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/theme_manager.dart';

import '../../domain/entities/message_user_entity.dart';
import '../blocs/message_bloc/messages_state.dart';

class MessageChatWidget extends StatelessWidget {
  final MessageUserEntity messageUserEntity;
  final SubmitStatus submitStatus;
  final bool sendingNow;

  const MessageChatWidget({
    super.key,
    required this.sendingNow,
    required this.submitStatus,
    required this.messageUserEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment:
              messageUserEntity.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment:
              messageUserEntity.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppPadding.p20,vertical: AppPadding.p5),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    messageUserEntity.isMe
                        ? BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        )
                        : BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                color:
                    messageUserEntity.isMe ? ColorManager.lightGray : ColorManager.primaryColor,
              ),
              padding: EdgeInsets.all(AppPadding.p14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(messageUserEntity.message, style: AppTheme.bodyText3),
                  Row(
                    mainAxisAlignment:
                        messageUserEntity.isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
                    children: [
                      if (!messageUserEntity.isMe) ...[
                        Text(
                          messageUserEntity.messageDateTime.toString(),
                          style: AppTheme.bodyText2,
                        ),
                        Gaps.hGap1,

                        SvgPicture.asset(AssetsManager.messages),
                      ] else ...[
                        Text(
                          messageUserEntity.messageDateTime.toString(),
                          style: AppTheme.bodyText2,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            if (sendingNow && messageUserEntity.isMe) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_buildMessageStatus()],
              ),
            ],
          ],
        );
      },
    );
  }

  Text _buildMessageStatus() {
    String text = 'sending now...';
    Color c = Colors.black;
    if (submitStatus == SubmitStatus.loading) {
      text = 'sending now...'.tr();
    } else if (submitStatus == SubmitStatus.offline ||
        submitStatus == SubmitStatus.error) {
      text = 'some thing went wrong'.tr();
      c = Colors.red;
    } else {
      text = '';
    }
    return Text(
      text,
      style: AppTheme.bodyText2.copyWith(color: c, fontSize: 10),
    );
  }
}
