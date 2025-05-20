import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/message_bloc/messages_bloc.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../widgets/inbox_messages_list.dart';
import '../widgets/inbox_popup_menu.dart';
import '../widgets/recently_chats.dart';
import 'new_chat_screen.dart';

class InboxMessagesScreen extends StatelessWidget {
  const InboxMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<MessagesBloc>()..add(LoadMessageEvent(userId: '')),
      child: Scaffold(
        appBar: getCustomAppBar(
          context: context,
          title: "inbox",
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NewChatScreen()));
                },
                child: SvgPicture.asset(AssetsManager.addChat),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: InboxPopupMenu()
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: "search",
                  withTitle: false,
                  onChanged: (value) {},
                ),
                RecentlyChats(),
                Expanded(child: InboxMessagesList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
