import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_list/widgets/SortBottomSheet%20.dart';
import '../widgets/request_list_item.dart';
import '../widgets/filter_chip_widget.dart';
import '../widgets/search_bar.dart';

class MyRequestsPage extends StatelessWidget {
  MyRequestsPage({super.key});
  static const routeName = "suggest_friends_screen";

  final List<Map<String, dynamic>> sentRequests = List.generate(15, (index) {
    return {
      'name': 'lorem ipsum',
      'mutualFriends': 12,
      'status': index % 4 == 1 || index % 4 == 2 ? 'Rejected' : 'Pending',
      'imageUrl': 'assets/images/',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('My requests', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                FilterChipWidget(label: "All requests", color: Colors.teal),
                FilterChipWidget(
                  label: "pending requests",
                  color: Color(0xFFB2DFDB),
                ),
                FilterChipWidget(
                  label: "Rejected requests",
                  color: Color(0xFFB2DFDB),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("15 Sent requests", style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => SortBottomSheet(),
                    );
                  },
                  child: const Text(
                    "Sort",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: sentRequests.length,
                itemBuilder: (context, index) {
                  return RequestListItem(request: sentRequests[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
