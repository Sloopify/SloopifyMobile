import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediaSection extends StatelessWidget {
  const MediaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text("Media, Links, Documents"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        SizedBox(
          height: 70.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  width: 60.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/media$index.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
