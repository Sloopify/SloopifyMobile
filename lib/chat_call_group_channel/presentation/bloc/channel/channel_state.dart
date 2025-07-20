import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/channel.dart';

abstract class ChannelState extends Equatable {
  const ChannelState();

  @override
  List<Object> get props => [];
}

class ChannelLoading extends ChannelState {}

class ChannelLoaded extends ChannelState {
  final List<Channel> channels;

  const ChannelLoaded(this.channels);

  @override
  List<Object> get props => [channels];
}
