import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/channel.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/channel/channel_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/channel/channel_event.dart';

class ChannelItem extends StatelessWidget {
  final Channel channel;

  const ChannelItem({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChannelBloc>();

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(channel.imageUrl)),
      title: Text(channel.name),
      subtitle: Text(channel.description),
      trailing: OutlinedButton(
        onPressed: () {
          bloc.add(ToggleFollowChannel(channel.id));
        },
        child: Text(channel.isFollowed ? "Followed" : "Follow"),
      ),
    );
  }
}
