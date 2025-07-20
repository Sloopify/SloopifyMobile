import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/channel/channel_bloc.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/channel/channel_event.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/channel/channel_state.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/widgets/channel/channel_item.dart';

class ChannelsPage extends StatelessWidget {
  const ChannelsPage({super.key});
  static const routeName = "channels";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChannelBloc()..add(const FetchChannels()),
      child: Scaffold(
        appBar: getCustomAppBar(title: ('Channels'), context: context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (value) {
                  context.read<ChannelBloc>().add(FetchChannels(query: value));
                },
                decoration: InputDecoration(
                  hintText: 'Search channel...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ChannelBloc, ChannelState>(
                builder: (context, state) {
                  if (state is ChannelLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChannelLoaded) {
                    if (state.channels.isEmpty) {
                      return const Center(child: Text('No channels found.'));
                    }
                    return ListView.builder(
                      itemCount: state.channels.length,
                      itemBuilder: (_, i) {
                        return ChannelItem(channel: state.channels[i]);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Failed to load channels.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
