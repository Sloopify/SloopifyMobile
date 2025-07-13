import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';
import '../../domain/entities/friend.dart';
import '../../domain/usecases/get_friend_list.dart';

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
