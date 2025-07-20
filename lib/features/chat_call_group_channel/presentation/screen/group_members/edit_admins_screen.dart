// edit_admins_screen.dart
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/screen/group_members/AdminsAndMembersList.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/screen/group_members/SelectedAdminsWidget.dart';

import 'package:sloopify_mobile/features/friend_list/presentation/widgets/search_bar.dart';

class EditAdminsScreen extends StatelessWidget {
  const EditAdminsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Edit admins"),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("2 of 20 selected"), // dynamic
          ),
          // Currently selected
          SelectedAdminsWidget(),
          SearchBarWidget(),
          Expanded(child: AdminsAndMembersList()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(onPressed: () {}, child: const Text("Next")),
          ),
        ],
      ),
    );
  }
}
