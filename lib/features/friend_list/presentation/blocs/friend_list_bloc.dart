import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/domain/repository/friend_list_repository.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';
import 'package:sloopify_mobile/core/local_storage/preferene_utils.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final FriendListRepository repository;
  String devToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODU3MjhjNmMxN2ZhYTRmN2UxMGI5MWUxYTA3MzNmMzhmODc2MjE0MzA2ZGNlNjgwODE1NDUzYWZmMWVkNWQyZmY5MTBiMTIyNWE4NmIxMDciLCJpYXQiOjE3NTM0NjA0MTAuNzY0NjYyLCJuYmYiOjE3NTM0NjA0MTAuNzY0NjY0LCJleHAiOjE3ODQ5OTY0MTAuNzU4Mzk4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.C0SBy8a_oaldiX22-PClyzxiM3KhhgXRO66aW1CwIApc9azFCOMeXR3dfxOVXOHwW94kHPOkmFWrX3r-S2BQZJtHsAeUQ0l7-OZXaTiV-bEaaS1OFONsJOfXmYXETqWKPyejT0xmUQd_7atsgQw-uAqs86P1figO3W37vK2aOpp8sttcU4e_9Ysqp_jYl-kqxgpJHCiCxeDw8oPFLieda1ixE6cbKKHuu8OVFKcrzvw2POwJKrrsz33PUqqmfqd2YKHcKWGvDfR5mp3tMnoUIFP5GubCuJ8rntwuCV17hQi2Warh3PWMfJVErRtPjbkGwOtoWL6Rpld6GRyLl92DR93zHySlBwozs37INXpqpKHDARsqZNOO1XkM6sr4OMiv-T1ATnS_UkLYd2FLuO50XCwLevx3Fd5eozwl4J5JCeMiRcFeJxwPMWprpCd5vzMALTqGnC2txQGN_DvtaH5KeC9xKLs8K4-RY-ed7BrO7Zw4nCApC3jFTBPVT_wQNhORbungmuEE_LlaXCeyhKbv2q6iMJSCMLOqJQ_qfPbY2jJftrddcRmpxJDpSZ8RWXoKmOSIZpyLKwu9fFmiVzueqxrvIZwNbVPD0U7aiHixUVQWqCxGuQJD8PtyqrGPoXCjSPBcFeJs29azCbf33dSgx648nFT-Wjysu6L3Kmf473I";

  FriendBloc(this.repository) : super(FriendInitial()) {
    // 👇 Load friends
    on<LoadFriends>((event, emit) async {
      emit(FriendLoading());
      try {
        final token = getToken();
        final friends = await repository.getFriendList(
          event.page,
          event.perPage,
          token,
        );
        emit(
          FriendLoaded(
            friends: friends,
            currentPage: event.page,
            perPage: event.perPage,
            hasMore: friends.length == event.perPage,
            isLoadingMore: false,
          ),
        );
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });

    // 👇 Search friends
    on<SearchFriendsEvent>((event, emit) async {
      emit(SearchLoading());
      try {
        final token = getToken();
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

    // 👇 Load sent friend requests
    on<LoadSentFriendRequests>((event, emit) async {
      emit(FriendLoading());
      try {
        final token = getToken();
        final requests = await repository.getSentFriendRequest(
          page: event.page,
          perPage: event.perPage,
          token: token,
          sortBy: event.sortBy,
          sortOrder: event.sortOrder,
          status: event.status,
        );
        emit(SentFriendRequestLoaded(requests));
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });

    // 👇 Load received friend requests
    on<LoadReceivedFriendRequests>((event, emit) async {
      emit(ReceivedFriendRequestLoading());
      try {
        final token = getToken();
        final requests = await repository.getReceivedFriendRequests(
          page: event.page,
          perPage: event.perPage,
          token: token,
          sortBy: event.sortBy,
          sortOrder: event.sortOrder,
          status: '',
        );
        emit(ReceivedFriendRequestLoaded(requests));
      } catch (e) {
        emit(ReceivedFriendRequestError(e.toString()));
      }
    });

    on<CancelFriendRequestEvent>((event, emit) async {
      try {
        final token = PreferenceUtils.getString("auth_token") ?? devToken;
        await repository.cancelFriendRequest(token, event.friendId);
        // Optionally emit success state or reload
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });

    on<SendFriendRequestEvent>((event, emit) async {
      try {
        final token = PreferenceUtils.getString("auth_token") ?? devToken;
        await repository.sendFriendRequest(token, event.friendId);
        // Optionally emit success state or reload
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });

    on<AcceptFriendRequestEvent>((event, emit) async {
      try {
        final token = PreferenceUtils.getString("auth_token") ?? devToken;
        await repository.acceptFriendRequest(token, event.friendshipId);
        // Optionally emit success state or reload
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });

    on<DeclineFriendRequestEvent>((event, emit) async {
      try {
        final token = PreferenceUtils.getString("auth_token") ?? devToken;
        await repository.declineFriendRequest(token, event.friendshipId);
        // Optionally emit success state or reload
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });

    on<DeleteFriendshipEvent>((event, emit) async {
      try {
        final token = PreferenceUtils.getString("auth_token") ?? devToken;
        await repository.deleteFriendship(token, event.friendId);
        // Optionally emit success state or reload
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });

    on<BlockFriendEvent>((event, emit) async {
      try {
        final token = PreferenceUtils.getString("auth_token") ?? devToken;
        await repository.blockFriend(token, event.friendId);
        // Optionally emit success state or reload
      } catch (e) {
        emit(FriendError(e.toString()));
      }
    });
  }

  /// 🔐 Gets token from preferences or uses fallback dev token
  String getToken() {
    final token = PreferenceUtils.getString("auth_token");
    if (token == null || token.isEmpty) {
      print("❌ No saved token. Using devToken.");
      return devToken;
    }
    print("✅ Got user token: $token");
    return token;
  }
}
