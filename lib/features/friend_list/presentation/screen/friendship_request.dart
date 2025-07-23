import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';

class FriendListPage extends StatefulWidget {
  static const routeName = "friendship_requests_screen";

  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;
  int _currentPage = 1;
  final int _perPage = 10;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    // ✅ Token is automatically read inside the BLoC, not passed from here
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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Friendship requests",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 1, 0, 0),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Search + Find button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      if (query.isNotEmpty) {
                        context.read<FriendBloc>().add(
                          SearchFriendsEvent(query: query, page: 1, perPage: 3),
                        );
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Search friends...",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      context.read<FriendBloc>().add(
                        SearchFriendsEvent(query: query, page: 1, perPage: 3),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

            // 🔢 Title & Sort
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Friend List",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Add sort logic
                  },
                  child: const Text(
                    "Sort",
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 🧠 BlocBuilder for list
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
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                friend.avatarUrl.isNotEmpty
                                    ? NetworkImage(friend.avatarUrl)
                                    : null,
                            child:
                                friend.avatarUrl.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                          ),
                          title: Text(friend.name),
                        );
                      },
                    );
                  }

                  if (state is FriendError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox(); // fallback
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
