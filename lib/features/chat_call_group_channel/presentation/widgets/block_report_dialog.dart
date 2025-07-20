import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/friend_chat/friend_chat_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/friend_chat/friend_chat_event.dart';

Future<void> showBlockReportDialog(BuildContext context) async {
  bool reportToSloopify = false;

  await showDialog(
    context: context,
    builder:
        (_) => StatefulBuilder(
          builder:
              (context, setState) => AlertDialog(
                title: const Text("Block Lorem Ipsum?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("They won't know you're blocked."),
                    CheckboxListTile(
                      title: const Text("Report to Sloopify"),
                      value: reportToSloopify,
                      onChanged: (value) {
                        setState(() {
                          reportToSloopify = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (reportToSloopify) {
                        context.read<ChatBloc>().add(
                          ReportUserEvent(alsoBlock: true),
                        );
                      } else {
                        context.read<ChatBloc>().add(BlockUserEvent());
                      }
                      Navigator.pop(context);
                    },
                    child: const Text("Block"),
                  ),
                ],
              ),
        ),
  );
}
