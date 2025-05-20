import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/chat_system/domain/entities/inbox_message_entity.dart';
import 'package:sloopify_mobile/features/chat_system/domain/entities/message_entity.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/message_bloc/messages_bloc.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/screens/chat_screen.dart';

import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/general_image.dart';
import '../screens/chat_example.dart';

class InboxMessageItem extends StatelessWidget {
  final MessageEntity messageEntity;

  const InboxMessageItem({super.key, required this.messageEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context)=>locator<ChatBloc>(),

                child: ChatScreenExample(senderName: messageEntity.senderName,),
              );
            },
          ),
        );
      },
      child: Row(
        children: [
          GeneralImage.circular(
            isNetworkImage: false,
            image: messageEntity.anotherPersonProfileImage,
            radius: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(4, 0),
                  spreadRadius: 0,
                  blurRadius: 4,
                  color: ColorManager.black.withOpacity(0.25),
                ),
              ],
              border: Border.all(color: ColorManager.primaryColor, width: 1.5),
            ),
          ),
          Gaps.hGap1,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                messageEntity.senderName,
                style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.bold),
              ),
              Gaps.vGap1,
              Text(
                messageEntity.message,
                style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (messageEntity.messagesNum > 0)
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(AppPadding.p8),
                  decoration: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${messageEntity.messagesNum}',
                    style: AppTheme.bodyText3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Text(
                '20:00',
                style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
