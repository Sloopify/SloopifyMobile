// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/friend_chat/friend_chat_bloc.dart';
// import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/friend_chat/friend_chat_state.dart';
// import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/chat_bubble.dart';
// import 'package:sloopify_mobile/features/chat_friend/presentation/widgets/chat_input.dart';
// import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/reply_preview.dart';

// class FriendChatPage extends StatelessWidget {
//   const FriendChatPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const ListTile(
//           contentPadding: EdgeInsets.zero,
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage('https://via.placeholder.com/150'),
//           ),
//           title: Text('Lorem Ipsum'),
//           subtitle: Text('Online now'),
//         ),
//         actions: [
//           IconButton(icon: Icon(Icons.call), onPressed: () {}),
//           IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<ChatBloc, ChatState>(
//               builder: (context, state) {
//                 return ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: state.messages.length,
//                   itemBuilder: (context, index) {
//                     final message = state.messages[index];
//                     return ChatBubble(message: message);
//                   },
//                 );
//               },
//             ),
//           ),
//           BlocBuilder<ChatBloc, ChatState>(
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   if (state.replyingTo != null)
//                     ReplyPreview(message: state.replyingTo!),
//                   const ChatInputField(),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
