import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/data/models/channel_model.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/channel.dart';
import 'channel_event.dart';
import 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  ChannelBloc() : super(ChannelLoading()) {
    on<FetchChannels>(_onFetchChannels);
    on<ToggleFollowChannel>(
      _onToggleFollowChannel,
    ); // 👈 This line must be inside the constructor
  }

  void _onFetchChannels(FetchChannels event, Emitter<ChannelState> emit) async {
    emit(ChannelLoading());

    await Future.delayed(Duration(milliseconds: 300)); // Simulated API delay

    final allChannels = List.generate(
      10,
      (i) => ChannelModel(
        id: 'ch_$i',
        name: 'Channel $i',
        description: 'Description of Channel $i',
        followed: i % 2 == 0,
      ),
    );

    final filtered =
        event.query.isEmpty
            ? allChannels
            : allChannels
                .where(
                  (c) =>
                      c.name.toLowerCase().contains(event.query.toLowerCase()),
                )
                .toList();

    emit(ChannelLoaded(filtered.cast<Channel>()));
  }

  void _onToggleFollowChannel(
    ToggleFollowChannel event,
    Emitter<ChannelState> emit,
  ) {
    if (state is ChannelLoaded) {
      final currentState = state as ChannelLoaded;

      final updatedChannels =
          currentState.channels.map((channel) {
            if (channel.id == event.channelId) {
              return channel.copyWith(
                isFollowed: !channel.isFollowed,
              ); // 👈 Key line
            }
            return channel;
          }).toList();

      emit(ChannelLoaded(updatedChannels));
    }
  }
}
