import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';

class GroupPermissionScreen extends StatefulWidget {
  const GroupPermissionScreen({super.key});

  @override
  State<GroupPermissionScreen> createState() => _GroupPermissionScreenState();
}

class _GroupPermissionScreenState extends State<GroupPermissionScreen> {
  bool canEditSettings = false;
  bool canSendMessages = true;
  bool canAddMembers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Group permissions", context: context),
      body: Column(
        children: [
          _buildSwitchTile(
            title: "Edit group settings",
            subtitle:
                "This includes the group name, group icon, group description and advanced chat privacy setting.",
            value: canEditSettings,
            onChanged: (v) => setState(() => canEditSettings = v),
          ),
          _buildSwitchTile(
            title: "Send messages",
            value: canSendMessages,
            onChanged: (v) => setState(() => canSendMessages = v),
          ),
          _buildSwitchTile(
            title: "Add new members",
            value: canAddMembers,
            onChanged: (v) => setState(() => canAddMembers = v),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "* If these options are not enabled, only the admin will be able to use them.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Done"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value,
      onChanged: onChanged,
    );
  }
}
