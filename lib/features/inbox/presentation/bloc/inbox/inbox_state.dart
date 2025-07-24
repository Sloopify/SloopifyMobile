import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/chat.dart';

abstract class InboxState extends Equatable {
  const InboxState();

  @override
  List<Object> get props => [];
}

class InboxInitial extends InboxState {}

class InboxLoading extends InboxState {}

class InboxLoaded extends InboxState {
  final List<Chat> chats;

  const InboxLoaded(this.chats);

  @override
  List<Object> get props => [chats];
}

class InboxError extends InboxState {
  final String message;

  const InboxError(this.message);

  @override
  List<Object> get props => [message];
}
