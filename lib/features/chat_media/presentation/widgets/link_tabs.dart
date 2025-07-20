import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/link_cubit.dart';
import '../../data/models/link_model.dart';
import '../widgets/link_tile.dart';

class LinksTab extends StatelessWidget {
  const LinksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkCubit, List<LinkModel>>(
      builder: (context, links) {
        if (links.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Today', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...links.map((link) => LinkTile(link: link)),
          ],
        );
      },
    );
  }
}
