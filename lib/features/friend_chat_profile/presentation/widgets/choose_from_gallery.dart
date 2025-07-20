import 'package:flutter/material.dart';

class ChooseFromGallery extends StatelessWidget {
  const ChooseFromGallery({super.key});
  static const routeName = "gallery_screen";

  @override
  Widget build(BuildContext context) {
    final backgrounds = [
      'assets/images/friendlist/ph1.jpg',
      'assets/images/friendlist/ph2.jpg',
      'assets/images/friendlist/ph3.jpg',
      'assets/images/friendlist/ph4.jpg',
      'assets/images/friendlist/ph1.jpg',
      'assets/images/friendlist/ph2.jpg',
      'assets/images/friendlist/ph3.jpg',
      'assets/images/friendlist/ph4.jpg',
      'assets/images/friendlist/ph1.jpg',
      'assets/images/friendlist/ph2.jpg',
      'assets/images/friendlist/ph3.jpg',
      'assets/images/friendlist/ph4.jpg',
      'assets/images/friendlist/ph1.jpg',
      'assets/images/friendlist/ph2.jpg',
      'assets/images/friendlist/ph3.jpg',
      'assets/images/friendlist/ph4.jpg',
      'assets/images/friendlist/ph1.jpg',
      'assets/images/friendlist/ph2.jpg',
      'assets/images/friendlist/ph3.jpg',
      'assets/images/friendlist/ph4.jpg',
      'assets/images/friendlist/ph1.jpg',
      'assets/images/friendlist/ph2.jpg',
      'assets/images/friendlist/ph3.jpg',
      'assets/images/friendlist/ph4.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select photo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: backgrounds.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // ← 4 items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final imagePath = backgrounds[index];
          return GestureDetector(
            onTap: () {
              // TODO: Save selected image
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
