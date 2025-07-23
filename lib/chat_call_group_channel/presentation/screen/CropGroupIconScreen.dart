import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_icon_picker_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_icon_picker_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_icon_picker_state.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';

class CropGroupIconScreen extends StatelessWidget {
  const CropGroupIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupIconBloc(),
      child: Scaffold(
        appBar: getCustomAppBar(context: context, title: "Group icon"),
        body: BlocBuilder<GroupIconBloc, GroupIconState>(
          builder: (context, state) {
            if (state.isCropping) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.imagePath == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No image selected"),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo),
                      label: const Text("Pick from Gallery"),
                      onPressed: () {
                        context.read<GroupIconBloc>().add(PickFromGallery());
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Capture with Camera"),
                      onPressed: () {
                        context.read<GroupIconBloc>().add(CaptureFromCamera());
                      },
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: ClipOval(
                      child: Image.file(
                        File(state.imagePath!),
                        fit: BoxFit.cover,
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _actionButton(context, "Done", () {
                        Navigator.pop(context, state.imagePath);
                      }),
                      _actionButton(context, "Cancel", () {
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, String text, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ElevatedButton(onPressed: onTap, child: Text(text)),
      ),
    );
  }
}
