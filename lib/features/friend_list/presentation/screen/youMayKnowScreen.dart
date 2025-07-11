import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/widgets/search_bar.dart';
import '../widgets/user_list_item.dart';

class YouMayKnowPage extends StatelessWidget {
  const YouMayKnowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = List.generate(12, (index) {
      return {
        'name': 'lorem ipsum',
        'mutualFriends': 12,
        'avatar': 'https://via.placeholder.com/150',
      };
    });

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'You may know',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserListItem(user: users[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
