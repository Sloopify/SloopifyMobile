// import 'package:flutter/material.dart';
// import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/widgets/chat_app_bar.dart';
// import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/widgets/myMsgList.dart';
// import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/widgets/mychatinputbar.dart';

// class ChatTypingScreen extends StatelessWidget {
//   const ChatTypingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: ChatAppBar(),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 8),
//           const Text("Today", style: TextStyle(color: Colors.grey)),
//           const SizedBox(height: 8),
//           Expanded(child: ChatMessageList()), // ✅ Fixed here
//           const Divider(height: 1),
//           ChatInputBar(),
//         ],
//       ),
//     );
//   }
// }
