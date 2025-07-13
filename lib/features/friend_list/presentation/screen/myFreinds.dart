import 'package:flutter/material.dart';

class MyFriendsPage extends StatelessWidget {
  const MyFriendsPage({super.key});
  static const routeName = "my_friends_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text("My friends", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
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
                    "find",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "251 Friends",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Sort", style: TextStyle(color: Colors.teal)),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const FriendItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendItem extends StatelessWidget {
  const FriendItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/1.jpg'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "lorem ipsum",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 8,
                      backgroundImage: AssetImage('assets/images/2.jpg'),
                    ),
                    SizedBox(width: 4),
                    CircleAvatar(
                      radius: 8,
                      backgroundImage: AssetImage('assets/images/3.jpg'),
                    ),
                    SizedBox(width: 4),
                    CircleAvatar(
                      radius: 8,
                      backgroundImage: AssetImage('assets/images/4.jpg'),
                    ),
                    SizedBox(width: 4),
                    Text("12 mutual friend", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chat_bubble_outline),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }
}
