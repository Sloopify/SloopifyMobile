import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/screen/myFreinds.dart';
import '../widgets/filter_button.dart';
import '../widgets/interest_card.dart';
import '../widgets/friend_request_card.dart';
import '../widgets/section_title.dart';

class SuggestedFriendListPage extends StatefulWidget {
  const SuggestedFriendListPage({super.key});
  static const routeName = "suggest_friends_screen";

  @override
  State<SuggestedFriendListPage> createState() =>
      _SuggestedFriendListPageState();
}

class _SuggestedFriendListPageState extends State<SuggestedFriendListPage> {
  final ScrollController _scrollController = ScrollController();
  final List<int> _items = List.generate(4, (index) => index);
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    setState(() => _isLoadingMore = true);

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    final nextItems = List.generate(4, (index) => _items.length + index);
    setState(() {
      _items.addAll(nextItems);
      _isLoadingMore = false;
    });
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
        padding: const EdgeInsets.all(16.0),
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => const InterestCard(),
              ),
            ),
            const SizedBox(height: 24),
            SectionTitle(title: "Friendship requests"),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _items.length + (_isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= _items.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const FriendRequestCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}
