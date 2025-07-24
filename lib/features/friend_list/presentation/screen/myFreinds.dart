import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/widgets/friend_item.dart';

class MyFriendsPage extends StatefulWidget {
  const MyFriendsPage({super.key});
  static const routeName = "my_friends_requests_screen";

  @override
  State<MyFriendsPage> createState() => _MyFriendsPageState();
}

class _MyFriendsPageState extends State<MyFriendsPage> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  final int _perPage = 10;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    // ✅ Automatically fetch using BLoC (token is handled internally)
    context.read<FriendBloc>().add(
      LoadFriends(page: _currentPage, perPage: _perPage),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _currentPage++;
      context.read<FriendBloc>().add(
        LoadFriends(page: _currentPage, perPage: _perPage),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSortBottomSheet() {
    // sort implementation later
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        title: const Text("My Friends", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search friends...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Trigger search event if needed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  child: const Text(
                    "Find",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Friend List",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: _showSortBottomSheet,
                  child: const Text(
                    "Sort",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ✅ BLoC-powered friend list
            Expanded(
              child: BlocBuilder<FriendBloc, FriendState>(
                builder: (context, state) {
                  if (state is FriendLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is FriendLoaded) {
                    final friends = state.friends;

                    if (friends.isEmpty) {
                      return const Center(child: Text("No friends found."));
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: friends.length,
                      itemBuilder: (_, index) {
                        final friend = friends[index];
                        return FriendItem(friend: friend); // Pass real friend
                      },
                    );
                  }

                  if (state is FriendError) {
                    return Center(child: Text("Error: ${state.message}"));
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
