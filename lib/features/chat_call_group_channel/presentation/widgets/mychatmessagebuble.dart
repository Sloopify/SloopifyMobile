// import 'package:flutter/material.dart';

// class ChatMessageBubble extends StatelessWidget {
//   final String message;
//   final String time;
//   final String? status;
//   final bool isSender;

//   const ChatMessageBubble({
//     super.key,
//     required this.message,
//     required this.time,
//     this.status,
//     this.isSender = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bubbleColor =
//         isSender ? const Color(0xFF00C27C) : const Color(0xFFF2F2F2);
//     final textColor = isSender ? Colors.white : Colors.black;

//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: bubbleColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(message, style: TextStyle(color: textColor)),
//             const SizedBox(height: 4),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   time,
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: textColor.withOpacity(0.7),
//                   ),
//                 ),
//                 if (status != null) ...[
//                   const SizedBox(width: 4),
//                   Icon(
//                     _getStatusIcon(status!),
//                     size: 14,
//                     color: status == "Read" ? Colors.white : Colors.white70,
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   IconData _getStatusIcon(String status) {
//     switch (status) {
//       case "Sent":
//         return Icons.check;
//       case "Delivered":
//         return Icons.done_all;
//       case "Read":
//         return Icons.done_all;
//       default:
//         return Icons.check;
//     }
//   }
// }

// class DeletedMessageBubble extends StatelessWidget {
//   final String message;
//   final bool isSender;

//   const DeletedMessageBubble({
//     super.key,
//     required this.message,
//     this.isSender = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: const Color(0xFFF2F2F2),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           message,
//           style: const TextStyle(
//             color: Colors.grey,
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//       ),
//     );
//   }
// }
