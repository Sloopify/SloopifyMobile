import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/screen/myRequests.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/screen/youMayKnowScreen.dart';

class FilterButton extends StatelessWidget {
  final String text;

  const FilterButton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          switch (text.toLowerCase()) {
            case 'friendship requests':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyRequestsPage()),
              );
              break;
            case 'my requests':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyRequestsPage()),
              );
              break;
            case 'you may know':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const YouMayKnowPage()),
              );
              break;
            default:
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Page not found')));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFDAF4F0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff14B8A6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
