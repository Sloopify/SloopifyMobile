import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/chat_bloc/chat_event.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/chat_bloc/chat_state.dart';

import '../../domain/entities/message_user_entity.dart';

class ChatInputField extends StatelessWidget {
  ChatInputField({super.key});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.symmetric(
            vertical: AppPadding.p14,
            horizontal: AppPadding.p20,
          ),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  initialValue: null,
                  hintText: "write your message here...",
                  withTitle: false,
                  controller: messageController,
                ),
              ),

              SizedBox(width: 8),

              InkWell(
                onTap: () {
                  context.read<ChatBloc>().add(
                    SendMessage(
                      messageUserEntity: MessageUserEntity(
                        senderUserId: "",
                        receiverUserId: "",
                        id: 'id',
                        message: messageController.text,
                        status: '',
                        isRead: true,
                        isRemoved: false,
                        isMe: true,
                        sendingNow: true,
                        messageDateTime: DateTime.now(),
                      ),
                    ),
                  );
                },
                child: SvgPicture.asset(AssetsManager.share2),
              ),
              SizedBox(width: 8),
            ],
          ),
        );
      },
    );
  }
}
