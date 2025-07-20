// lib/features/inbox/presentation/widgets/starred_message_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/features/inbox/presentation/screen/starred_msgs_screen.dart';

class StarredMessageTile extends StatelessWidget {
  final StarMessage message;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const StarredMessageTile({
    super.key,
    required this.message,
    this.isSelected = false,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        color: isSelected ? Colors.grey.shade300 : Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: const NetworkImage(
                'https://via.placeholder.com/150',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${message.sender} › ${message.isSentByMe ? 'You' : message.sender}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color:
                          message.isSentByMe
                              ? Colors.tealAccent.shade100
                              : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(message.content),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.date,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                SizedBox(height: 4.h),
                Text(message.time, style: TextStyle(fontSize: 12.sp)),
                SizedBox(height: 4.h),
                isSelected
                    ? Icon(Icons.check_box, color: Colors.teal)
                    : const Icon(Icons.check_box_outline_blank),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
