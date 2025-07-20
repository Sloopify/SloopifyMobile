import 'package:flutter/material.dart';

class OptionRow extends StatelessWidget {
  final String? image;
  final IconData? icon;
  final String label;
  final Widget? trailing;

  const OptionRow({
    super.key,
    this.image,
    this.icon,
    required this.label,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset("'assets/images/friendlist/group.jpg"),
      title: Text(label),
      trailing: trailing,
    );
  }
}
