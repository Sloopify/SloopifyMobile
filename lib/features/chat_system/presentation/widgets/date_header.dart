import 'package:flutter/cupertino.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

class DateHeader extends StatelessWidget {
  final String date;
  const DateHeader({required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(child: Text(date, style: AppTheme.bodyText3)),
    );
  }
}