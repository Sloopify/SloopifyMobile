import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/channel.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/user.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/freinds_list.dart';

class EditAdminsScreen extends StatefulWidget {
  final Channel channel;

  const EditAdminsScreen({super.key, required this.channel});

  @override
  State<EditAdminsScreen> createState() => _EditAdminsScreenState();
}

class _EditAdminsScreenState extends State<EditAdminsScreen> {
  final selected = <User>[]; // Track selection

  @override
  void initState() {
    super.initState();
    // preload current admins
    selected.addAll(widget.channel.admins);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: ("Edit admins"), context: context),
      body: Column(
        children: [
          SizedBox(height: 8.h),
          Text("${selected.length} of ?? selected"),
          SizedBox(height: 8.h),
          SizedBox(
            height: 70.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selected.length,
              itemBuilder: (_, i) {
                final u = selected[i];
                return Stack(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(u.imageUrl)),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: GestureDetector(
                        onTap: () => setState(() => selected.remove(u)),
                        child: Icon(Icons.cancel, color: Colors.red, size: 16),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SearchBar(
            onChanged: (q) {
              /* filter logic */
            },
          ),
          Expanded(
            child: FriendsList(

            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: ElevatedButton(
              child: Text("Next"),
              onPressed: () {
                // dispatch update
              },
            ),
          ),
        ],
      ),
    );
  }
}
