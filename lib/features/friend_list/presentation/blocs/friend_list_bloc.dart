import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/domain/repository/friend_list_repository.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';
import 'package:sloopify_mobile/core/local_storage/preferene_utils.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final FriendListRepository repository;

  FriendBloc(this.repository) : super(FriendInitial()) {
    // Load friends
    on<LoadFriends>((event, emit) async {
      emit(FriendLoading());
      try {
        final token = PreferenceUtils.getString("auth_token") ?? "";
        final friends = await repository.getFriendList(
          event.page,
          event.perPage,
          token,
        );
        emit(FriendLoaded(friends));
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });

    on<SearchFriendsEvent>((event, emit) async {
      emit(SearchLoading());
      try {
        final token = PreferenceUtils.getString("auth_token") ?? "";
        final results = await repository.searchFriends(
          event.query,
          event.page,
          event.perPage,
          token,
        );
        emit(SearchLoaded(results));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });

    on<LoadReceivedFriendRequests>((event, emit) async {
      emit(ReceivedFriendRequestLoading());
      try {
        final token = PreferenceUtils.getString("auth_token") ?? "";
        final requests = await repository.getReceivedFriendRequests(
          page: event.page,
          perPage: event.perPage,
          token: token, // ✅ fix here
          sortBy: event.sortBy,
          sortOrder: event.sortOrder,
        );
        emit(ReceivedFriendRequestLoaded(requests));
      } catch (e) {
        emit(ReceivedFriendRequestError(e.toString()));
      }
    });
  }
}
