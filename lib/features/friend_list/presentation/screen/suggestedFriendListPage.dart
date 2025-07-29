import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';
import '../widgets/filter_button.dart';
import '../widgets/interest_card.dart';
import '../widgets/friend_request_card.dart';
import '../widgets/section_title.dart';
import 'myFreinds.dart';

class SuggestedFriendListPage extends StatefulWidget {
  const SuggestedFriendListPage({super.key});
  static const routeName = "suggest_friends_screen";

  @override
  State<SuggestedFriendListPage> createState() =>
      _SuggestedFriendListPageState();
}

class _SuggestedFriendListPageState extends State<SuggestedFriendListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FriendBloc>().add(LoadFriends(page: 1, perPage: 10));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<FriendBloc>().state;
    if (state is FriendLoaded &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !state.isLoadingMore &&
        state.hasMore) {
      context.read<FriendBloc>().add(LoadMoreFriends());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyFriendsPage()),
                );
              },
              icon: const Icon(Icons.people_outline, color: Color(0xff14B8A6)),
              label: const Text(
                "My Friends",
                style: TextStyle(color: Color(0xff14B8A6)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDAF4F0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Static Filter Buttons (won't disappear)
            Row(
              children: const [
                FilterButton("Friendship requests"),
                SizedBox(width: 8),
                FilterButton("My requests"),
                SizedBox(width: 8),
                FilterButton("You may know"),
              ],
            ),
            const SizedBox(height: 24),
            SectionTitle(title: "They sharing you same interests"),
            const SizedBox(height: 12),
            BlocBuilder<FriendBloc, FriendState>(
              builder: (context, state) {
                if (state is FriendLoaded) {
                  return SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final friend = state.friends[index];
                        return InterestCard(friend: friend);
                      },
                    ),
                  );
                } else if (state is FriendLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FriendError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 24),
            SectionTitle(title: "Friendship requests"),
            const SizedBox(height: 12),

            // BlocBuilder for friend requests
            BlocBuilder<FriendBloc, FriendState>(
              builder: (context, state) {
                if (state is FriendLoading && (state is! FriendLoaded)) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FriendLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        state.friends.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.friends.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final friend = state.friends[index];
                      return FriendRequestCard(friend: friend);
                    },
                  );
                } else if (state is FriendError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
