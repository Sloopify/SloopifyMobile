import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';

import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/group/group_bloc.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/group/group_event.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/group/group_state.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/group/group_icon_picker_bloc.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/group/group_icon_picker_event.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/group/group_icon_picker_state.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/screen/CropGroupIconScreen.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/screen/GroupPermissionScreen.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/screen/SelectPhotoScreen.dart';

import 'package:sloopify_mobile/features/chat_friend/presentation/widgets/group/friend_search_delegate.dart';

import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';

class GroupCreateScreen extends StatelessWidget {
  const GroupCreateScreen({super.key});
  static const String routeName = 'create_group';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  GroupBloc(getAllFriendsUseCase: context.read())
                    ..add(LoadFriends()),
        ),
        BlocProvider(create: (_) => GroupIconBloc()),
      ],
      child: const GroupCreateView(),
    );
  }
}

class GroupCreateView extends StatefulWidget {
  const GroupCreateView({super.key});

  @override
  State<GroupCreateView> createState() => _GroupCreateViewState();
}

class _GroupCreateViewState extends State<GroupCreateView> {
  void _openSortModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.sort_by_alpha),
                title: const Text('Sort from A to Z'),
                onTap: () {
                  context.read<GroupBloc>().add(const SortFriends(true));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.sort_by_alpha_outlined),
                title: const Text('Sort from Z to A'),
                onTap: () {
                  context.read<GroupBloc>().add(const SortFriends(false));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFriendTile(Friend friend, bool selected, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(friend.avatarUrl as String),
      ),
      title: Text(friend.name),
      trailing:
          selected ? const Icon(Icons.check_circle, color: Colors.teal) : null,
      onTap: () => context.read<GroupBloc>().add(ToggleFriendSelection(friend)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupIconBloc, GroupIconState>(
      listenWhen:
          (prev, curr) =>
              prev.imagePath != curr.imagePath && curr.imagePath != null,
      listener: (context, state) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CropGroupIconScreen()),
        );
      },
      child: Scaffold(
        appBar: getCustomAppBar(
          title: "New Group",
          context: context,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: FriendSearchDelegate(context.read<GroupBloc>()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Group icon picker
                  GestureDetector(
                    onTap: () {
                      context.read<GroupIconBloc>().add(PickFromGallery());
                    },
                    child: BlocBuilder<GroupIconBloc, GroupIconState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              state.imagePath != null
                                  ? FileImage(File(state.imagePath!))
                                  : null,
                          child:
                              state.imagePath == null
                                  ? const Icon(Icons.camera_alt, size: 32)
                                  : null,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Permission & Predefined Photo Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const GroupPermissionScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.lock),
                        label: const Text("Permissions"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SelectPhotoScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.image),
                        label: const Text("Choose Icon"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Selected friends preview
                  if (state.selectedFriends.isNotEmpty)
                    SizedBox(
                      height: 70.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.selectedFriends.length,
                        itemBuilder: (_, index) {
                          final f = state.selectedFriends[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        f.avatarUrl as String,
                                      ),
                                      radius: 20,
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<GroupBloc>().add(
                                            RemoveSelectedFriend(f),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  f.name,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ListTile(
                    title: const Text("Your Friends"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${state.allFriends.length} Friends'),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _openSortModal(context),
                          child: const Text(
                            'Sort',
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.filteredFriends.length,
                      itemBuilder: (_, index) {
                        final f = state.filteredFriends[index];
                        final isSelected = state.selectedFriends.contains(f);
                        return _buildFriendTile(f, isSelected, context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<GroupBloc, GroupState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed:
                    state.selectedFriends.isNotEmpty
                        ? () {
                          Navigator.pushNamed(
                            context,
                            '/group/summary',
                            arguments: state.selectedFriends,
                          );
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Next"),
              ),
            );
          },
        ),
      ),
    );
  }
}
