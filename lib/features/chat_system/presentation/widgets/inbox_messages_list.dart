import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/message_bloc/messages_bloc.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/message_bloc/messages_state.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/widgets/inbox_message_item.dart';

import '../../../../core/managers/app_gaps.dart' show Gaps;

class InboxMessagesList extends StatelessWidget {
  InboxMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesBloc, GetMessageState>(
      builder: (context, state) {
        if (state.status == GetMessageStatus.loading) {
          return Center(child: CircularProgressIndicator(),);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap2,
            Text(
              'Messages',
              style: AppTheme.headline4.copyWith(fontWeight: FontWeight.bold),
            ),
            Gaps.vGap2,
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InboxMessageItem(messageEntity: state.data[index]);
              },
              separatorBuilder: (context, index) {
                return Gaps.vGap2;
              },
              itemCount: state.data.length,
            ),
          ],
        );
      },
    );
  }
}
