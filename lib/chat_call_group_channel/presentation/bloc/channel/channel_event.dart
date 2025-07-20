import 'package:equatable/equatable.dart';

abstract class ChannelEvent extends Equatable {
  const ChannelEvent();

  @override
  List<Object> get props => [];
}

class FetchChannels extends ChannelEvent {
  final String query;

  const FetchChannels({this.query = ""});

  @override
  List<Object> get props => [query];
}

class ToggleFollowChannel extends ChannelEvent {
  final String channelId;

  const ToggleFollowChannel(this.channelId);

  @override
  List<Object> get props => [channelId];
}
