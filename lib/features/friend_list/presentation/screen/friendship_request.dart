import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/widgets/SortBottomSheet%20.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Friendship requests",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search & Find button
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                      onChanged: (query) {
                        if (query.isNotEmpty) {
                          context.read<FriendBloc>().add(
                            SearchFriendsEvent(
                              query: query,
                              page: 1,
                              perPage: 3,
                            ),
                          );
                        }
                      },
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
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "find",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Title & Sort
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<FriendBloc, FriendState>(
                  builder: (context, state) {
                    int totalCount = 0;
                    if (state is FriendLoaded) {
                      totalCount = state.friends.length;
                    }
                    return Text(
                      "$totalCount Friendship requests",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) {
                        return SortBottomSheet(
                          onSelect: (option) {
                            // Add sorting implementation
                            // For now, just print the selection
                            print("Selected sort: $option");

                            // If you want to sort the already loaded friends in memory
                            // You can dispatch a new event or call setState here
                          },
                        );
                      },
                    );
                  },
                  child: const Text(
                    "Sort",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Friends list
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
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage:
                                    friend.avatarUrl.isNotEmpty
                                        ? NetworkImage(friend.avatarUrl)
                                        : null,
                                child:
                                    friend.avatarUrl.isEmpty
                                        ? const Icon(Icons.person, size: 24)
                                        : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      friend.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "12 mutual friend",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  _actionButton(Icons.check, Colors.teal),
                                  const SizedBox(width: 8),
                                  _actionButton(Icons.close, Colors.grey[400]!),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (state is FriendError) {
                    return Center(child: Text(state.message));
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

  Widget _actionButton(IconData icon, Color color) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}
