import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_media_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_media_state.dart';

class MediaTabView extends StatelessWidget {
  const MediaTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMediaCubit, ChatMediaState>(
      builder: (context, state) {
        if (state.mediaByDate.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.mediaByDate.length,
          itemBuilder: (context, index) {
            final sectionTitle = state.mediaByDate.keys.elementAt(index);
            final mediaList = state.mediaByDate[sectionTitle]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sectionTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (_, i) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        mediaList[i].imagePath,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            );
          },
        );
      },
    );
  }
}
