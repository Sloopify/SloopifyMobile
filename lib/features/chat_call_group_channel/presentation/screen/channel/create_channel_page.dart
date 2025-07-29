import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/create_channel/create_channel_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/create_channel/create_channel_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/create_channel/create_channel_state.dart';

class CreateChannelPage extends StatelessWidget {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  CreateChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateChannelBloc(),
      child: BlocBuilder<CreateChannelBloc, CreateChannelState>(
        builder: (context, state) {
          final bloc = context.read<CreateChannelBloc>();
          return Scaffold(
            appBar: getCustomAppBar(title: 'New Channel', context: context),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _showImagePicker(context),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundImage:
                          state.imagePath != null
                              ? _getImageProvider(state.imagePath!)
                              : null,
                      child:
                          state.imagePath == null
                              ? Icon(Icons.image, size: 40)
                              : null,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Channel name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: descController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Channel description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (state.inviteLink != null)
                    Row(
                      children: [
                        Expanded(child: SelectableText(state.inviteLink!)),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            // Add sharing functionality here
                          },
                        ),
                      ],
                    ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed:
                        state.isLoading
                            ? null
                            : () => bloc.add(
                              SubmitChannel(
                                nameController.text,
                                descController.text,
                              ),
                            ),
                    child:
                        state.isLoading
                            ? CircularProgressIndicator()
                            : Text("Create"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ImageProvider _getImageProvider(String imagePath) {
    if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else {
      return FileImage(File(imagePath));
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<CreateChannelBloc>().add(
                      PickImage(fromCamera: true),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    context.read<CreateChannelBloc>().add(
                      PickImage(fromCamera: false),
                    );
                  },
                ),
              ],
            ),
          ),
    );
  }
}
