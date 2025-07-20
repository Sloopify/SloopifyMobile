import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/color_picker_screen.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/choose_from_gallery.dart';

class ChatBackgroundScreen extends StatelessWidget {
  const ChatBackgroundScreen({super.key});
  static const routeName = "background_screen";

  @override
  Widget build(BuildContext context) {
    final backgrounds = [
      'assets/images/friendlist/bg1.jpg',
      'assets/images/friendlist/bg2.jpg',
      'assets/images/friendlist/bg3.jpg',
      'assets/images/friendlist/bg4.jpg',
      'assets/images/friendlist/bg5.jpg',
      'assets/images/friendlist/bg6.jpg',
      'assets/images/friendlist/bg7.jpg',
      'assets/images/friendlist/bg8.jpg',
      'assets/images/friendlist/bg9.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Background'),
        actions: [
          Tooltip(
            message: 'Reset default setting',
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // TODO: Reset background logic
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from gallery'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChooseFromGallery()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Colored background'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ColorPickerScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Application background',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // 3-column Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: backgrounds.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 3, // Matches your 100x150 ratio
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // TODO: Handle background selection
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(backgrounds[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
