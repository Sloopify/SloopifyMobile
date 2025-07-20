import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/group/group_icon_picker_bloc.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/group/group_icon_picker_event.dart';

class SelectPhotoScreen extends StatelessWidget {
  const SelectPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Select photo", context: context),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 20, // Replace with real image list later
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.read<GroupIconBloc>().add(PickFromGallery());
            },
            child: Container(
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 30),
            ),
          );
        },
      ),
    );
  }
}
