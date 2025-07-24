import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/useCases/get_all_friends_usecase.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GetAllFriendsUseCase getAllFriendsUseCase;

  GroupBloc({required this.getAllFriendsUseCase}) : super(const GroupState()) {
    on<LoadFriends>(_onLoadFriends);
    on<SearchFriend>(_onSearchFriend);
    on<ToggleFriendSelection>(_onToggleFriendSelection);
    on<RemoveSelectedFriend>(_onRemoveFriend);
    on<SortFriends>(_onSortFriends);
  }

  void _onLoadFriends(LoadFriends event, Emitter<GroupState> emit) async {
    emit(state.copyWith(isLoading: true));
    final friends = await getAllFriendsUseCase();
    emit(
      state.copyWith(
        allFriends: friends,
        filteredFriends: friends,
        isLoading: false,
      ),
    );
  }

  void _onSearchFriend(SearchFriend event, Emitter<GroupState> emit) {
    final query = event.query.toLowerCase();
    final filtered =
        state.allFriends
            .where((f) => f.name.toLowerCase().contains(query))
            .toList();
    emit(state.copyWith(filteredFriends: filtered, searchQuery: event.query));
  }

  void _onToggleFriendSelection(
    ToggleFriendSelection event,
    Emitter<GroupState> emit,
  ) {
    final alreadySelected = state.selectedFriends.contains(event.friend);
    final updated =
        alreadySelected
            ? (state.selectedFriends..remove(event.friend))
            : (List.of(state.selectedFriends)..add(event.friend));
    emit(state.copyWith(selectedFriends: updated));
  }

  void _onRemoveFriend(RemoveSelectedFriend event, Emitter<GroupState> emit) {
    final updated = List.of(state.selectedFriends)..remove(event.friend);
    emit(state.copyWith(selectedFriends: updated));
  }

  void _onSortFriends(SortFriends event, Emitter<GroupState> emit) {
    final sorted = List.of(state.filteredFriends)..sort(
      (a, b) =>
          event.ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name),
    );
    emit(state.copyWith(filteredFriends: sorted, isAscending: event.ascending));
  }
}
