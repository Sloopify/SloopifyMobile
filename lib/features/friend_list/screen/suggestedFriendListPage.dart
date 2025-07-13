import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_list/screen/myFreinds.dart';
import '../widgets/filter_button.dart';
import '../widgets/interest_card.dart';
import '../widgets/friend_request_card.dart';
import '../widgets/section_title.dart';

class SuggestedFriendListPage extends StatelessWidget {
  const SuggestedFriendListPage({super.key});
  static const routeName = "suggest_friends_screen";

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
              itemCount: 4,
              itemBuilder: (context, index) => const FriendRequestCard(),
            ),
          ],
        ),
      ),
    );
  }
}
