// import 'package:flutter/material.dart';

// class MutedMsgDurationWidget extends StatelessWidget {
//   final Duration selectedDuration;
//   final void Function(Duration) onDurationSelected;

//   const MutedMsgDurationWidget({
//     Key? key,
//     required this.selectedDuration,
//     required this.onDurationSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final durations = <Duration>[
//       Duration(minutes: 15),
//       Duration(hours: 1),
//       Duration(hours: 8),
//       Duration(days: 1),
//     ];

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children:
//           durations.map((duration) {
//             return RadioListTile<Duration>(
//               title: Text(_formatDuration(duration)),
//               value: duration,
//               groupValue: selectedDuration,
//               onChanged: onDurationSelected,
//             );
//           }).toList(),
//     );
//   }

//   String _formatDuration(Duration duration) {
//     if (duration.inMinutes == 15) return '15 Minutes';
//     if (duration.inHours == 1) return '1 Hour';
//     if (duration.inHours == 8) return '8 Hours';
//     if (duration.inDays == 1) return '1 Day';
//     return '${duration.inMinutes} Minutes';
//   }
// }
