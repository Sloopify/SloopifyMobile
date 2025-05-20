import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_system/domain/entities/message_user_entity.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/message_bloc/messages_state.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/widgets/chat_fab_options.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/assets_managers.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import '../blocs/chat_bloc/chat_event.dart';
import '../blocs/chat_bloc/chat_state.dart';
import '../widgets/chat_input_message.dart';
import '../widgets/date_header.dart';
import '../widgets/message_chat_widget.dart';

class ChatScreenExample extends StatefulWidget {
  final String senderName;

  const ChatScreenExample({super.key, required this.senderName});

  @override
  _ChatScreenExampleState createState() => _ChatScreenExampleState();
}

class _ChatScreenExampleState extends State<ChatScreenExample> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(FetchInitialMessages());

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        final state = context.read<ChatBloc>().state;
        if (state is ChatLoaded && state.hasMore) {
          context.read<ChatBloc>().add(FetchMoreMessages());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ChatFabOptions(),
      appBar: getCustomAppBar(
        context: context,
        title: widget.senderName,
        centerTitle: true,
        actions:
            [
              Gaps.hGap4,

              SvgPicture.asset(AssetsManager.inboxInfo),
              Gaps.hGap3,
              SvgPicture.asset(AssetsManager.videoCall),
              Gaps.hGap3,
              SvgPicture.asset(AssetsManager.call),
            ].reversed.toList(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ChatError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is ChatLoaded) {
                    final grouped = groupMessagesByDate(
                      state.messages.reversed.toList(),
                    );

                    final List<Widget> items =
                        grouped.entries.expand((entry) {
                          return [
                            ...entry.value.reversed.map(
                              (msg) => MessageChatWidget(
                                messageUserEntity: msg,
                                sendingNow: false,
                                submitStatus: SubmitStatus.init,
                              ),
                            ),
                            DateHeader(date: entry.key),
                          ]..reversed.toList();
                        }).toList();

                    return ListView.builder(
                      controller: _controller,
                      itemCount: items.length,
                      reverse: true,
                      itemBuilder: (context, index) => items[index],
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
            ChatInputField(),
          ],
        ),
      ),
    );
  }

  Map<String, List<MessageUserEntity>> groupMessagesByDate(
    List<MessageUserEntity> messages,
  ) {
    final Map<String, List<MessageUserEntity>> grouped = {};

    for (var message in messages) {
      final key = formatDateForHeader(message.messageDateTime);
      grouped.putIfAbsent(key, () => []).add(message);
    }
    return Map.fromEntries(
      grouped.entries.toList()..sort(
        (a, b) => b.value.first.messageDateTime.compareTo(
          a.value.first.messageDateTime,
        ),
      ),
    );
  }

  String formatDateForHeader(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    return '${date.day}/${date.month}/${date.year}';
  }
}
