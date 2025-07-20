import 'package:flutter/material.dart';

class PrivacyOptions extends StatelessWidget {
  const PrivacyOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          leading: Icon(Icons.lock),
          title: Text("Encryption"),
          subtitle: Text("Messages are end-to-end encrypted."),
        ),
        ListTile(
          leading: Icon(Icons.security),
          title: Text("Disappearing messages"),
        ),
      ],
    );
  }
}
