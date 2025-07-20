import 'package:equatable/equatable.dart';

abstract class InboxEvent extends Equatable {
  const InboxEvent();

  @override
  List<Object> get props => [];
}

class LoadInbox extends InboxEvent {}

class RefreshInbox extends InboxEvent {}

class MarkChatAsRead extends InboxEvent {
  final String chatId;

  const MarkChatAsRead(this.chatId);

  @override
  List<Object> get props => [chatId];
}
