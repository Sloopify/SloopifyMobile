import 'package:flutter/material.dart';
import 'option_row.dart';

class OptionsList extends StatelessWidget {
  const OptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        OptionRow(
          icon: Icons.notifications,
          label: 'Notification',
          trailing: Text('All'),
        ),
        OptionRow(icon: Icons.star_border, label: 'Starred message'),
        OptionRow(
          icon: Icons.lock,
          label: 'Encryption',
          trailing: Text.rich(
            TextSpan(
              text: 'Messages and calls are end-to-end encrypted. ',
              children: [
                TextSpan(
                  text: 'Tap to know more.',
                  style: TextStyle(color: Colors.teal),
                ),
              ],
            ),
            style: TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
