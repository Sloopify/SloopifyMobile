import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/useCases/get_inbox_chats.dart';
import 'inbox_event.dart';
import 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final GetInboxChats getInboxChats;

  InboxBloc({required this.getInboxChats}) : super(InboxInitial()) {
    on<LoadInbox>(_onLoadInbox);
    on<RefreshInbox>(_onRefreshInbox);
  }

  Future<void> _onLoadInbox(LoadInbox event, Emitter<InboxState> emit) async {
    emit(InboxLoading());
    final result = await getInboxChats();
    emit(
      result.fold(
        (failure) => InboxError("fail to load"),
        (chats) => InboxLoaded(chats),
      ),
    );
  }

  Future<void> _onRefreshInbox(
    RefreshInbox event,
    Emitter<InboxState> emit,
  ) async {
    final result = await getInboxChats();
    emit(
      result.fold(
        (failure) => InboxError("fail to refresh"),
        (chats) => InboxLoaded(chats),
      ),
    );
  }
}
