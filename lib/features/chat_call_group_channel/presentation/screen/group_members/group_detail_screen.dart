import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group_members/group_members_bloc.dart';

import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group_members/group_members_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group_members/group_members_state.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/widgets/group_details/_GroupOptions.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/widgets/group_details/_MemberList.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/widgets/group_details/actionButton.dart';
import 'package:sloopify_mobile/features/profile/presentation/widgets/media_section.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});
  static const routeName = "group_details";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupBloc()..add(const LoadGroupDetails("group_123")),
      child: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.groupName),
              actions: [
                if (state.isAdmin)
                  IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 50.r),
                  SizedBox(height: 12.h),
                  Text(
                    state.groupName,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(state.groupDesc, style: TextStyle(fontSize: 14.sp)),
                  SizedBox(height: 20.h),

                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionButton(
                        icon: Icons.search,
                        label: "Search",
                        onTap: () {},
                      ),

                      if (state.isAdmin)
                        ActionButton(
                          icon: Icons.share,
                          label: "Share",
                          onTap: () {},
                        ),
                      ActionButton(icon: Icons.add, label: "Add", onTap: () {}),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Media Preview
                  MediaSection(media: []),

                  // Group Options
                  GroupOptions(isAdmin: state.isAdmin),

                  // Member List
                  MemberList(members: state.members),

                  // Danger Zone
                  const Divider(),
                  ListTile(
                    title: const Text(
                      'Leave the group',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () => context.read<GroupBloc>().add(LeaveGroup()),
                  ),
                  ListTile(
                    title: const Text(
                      'Report group',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () => context.read<GroupBloc>().add(ReportGroup()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
