import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';

class ReviewSelectedAlbums extends StatelessWidget {
  const ReviewSelectedAlbums({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context,title: ""),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      )),
    );
  }
}
