import 'package:bloc/bloc.dart';
import 'package:sloopify_mobile/features/friend_list/domain/use_cases/get_friend_list.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';

class FriendListBloc extends Bloc<FriendListEvent, FriendListState> {
  final GetFriendList getFriendList;

  FriendListBloc({required this.getFriendList}) : super(FriendListInitial()) {
    on<LoadFriendList>((event, emit) async {
      emit(FriendListLoading());
      try {
        final friends = await getFriendList();
        emit(FriendListLoaded(friends));
      } catch (_) {
        emit(FriendListError());
      }
    });
  }
}
