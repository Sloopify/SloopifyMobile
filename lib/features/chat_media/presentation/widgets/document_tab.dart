import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_media/data/models/document_model.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_friend_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/widgets/document_tile.dart';

class DocumentTab extends StatelessWidget {
  const DocumentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatFriendCubit, List<DocumentModel>>(
      builder: (context, documents) {
        if (documents.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Today', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...documents.map((doc) => DocumentTile(document: doc)),
          ],
        );
      },
    );
  }
}
