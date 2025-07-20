import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/channel.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/user.dart';

class TransferOwnershipScreen extends StatefulWidget {
  final Channel channel;

  const TransferOwnershipScreen({super.key, required this.channel});

  @override
  State<TransferOwnershipScreen> createState() =>
      _TransferOwnershipScreenState();
}

class _TransferOwnershipScreenState extends State<TransferOwnershipScreen> {
  User? selectedOwner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: ("Transfer ownership"), context: context),
      body: Column(
        children: [
          SearchBar(
            onChanged: (q) {
              /* filter admins list */
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.channel.admins.length,
              itemBuilder: (_, i) {
                final u = widget.channel.admins[i];
                return RadioListTile<User>(
                  value: u,
                  groupValue: selectedOwner,
                  title: Row(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(u.imageUrl)),
                      SizedBox(width: 12.w),
                      Text(u.name),
                    ],
                  ),
                  onChanged: (v) => setState(() => selectedOwner = v),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: ElevatedButton(
              onPressed:
                  selectedOwner != null
                      ? () {
                        // call transfer ownership logic
                      }
                      : null,
              child: Text("Done"),
            ),
          ),
        ],
      ),
    );
  }
}
