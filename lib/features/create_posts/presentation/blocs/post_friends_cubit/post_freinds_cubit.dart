import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/get_friends_list_use_case.dart';
import '../../../domain/use_cases/search_friend_use_case.dart';

part 'post_freinds_state.dart';

class PostFriendsCubit extends Cubit<PostFriendsState> {
  final GetFriendsListUseCase getFriendsListUseCase;
  final SearchFriendsListUseCase searchFriendsListUseCase;

  PostFriendsCubit({
    required this.getFriendsListUseCase,
    required this.searchFriendsListUseCase,
  }) : super(PostFriendsState());

  setSearchFriendName(String value) {
    emit(
      state.copyWith(
        searchName: value,
        getAllFriendStatus: GetAllFriendStatus.init,
      ),
    );
  }

  getFriendsList() async {
    emit(state.copyWith(getAllFriendStatus: GetAllFriendStatus.loading));
    final res = await getFriendsListUseCase.call();
    res.fold(
      (l) {
        _mapFailureGetFriendsToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getAllFriendStatus: GetAllFriendStatus.success,
            allFriends: r,
          ),
        );
      },
    );
  }

  searchFriendsList() async {
    emit(state.copyWith(getAllFriendStatus: GetAllFriendStatus.loading));
    final res = await searchFriendsListUseCase.call(
      friendName: state.searchName,
    );
    res.fold(
      (l) {
        _mapFailureGetFriendsToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getAllFriendStatus: GetAllFriendStatus.success,
            allFriends: r,
            selectedSpecificFriends:
                r.where((e) => e.isSpecificFriend!).map((e) => e.id).toList(),
            selectedFriendsExcept:
                r.where((e) => e.friendsExcept!).map((e) => e.id).toList(),
          ),
        );
      },
    );
  }

  void toggleSelectSpecificFriends(int friendId) {
    List<int> newSelectedSpecificFrineds = List.from(state.selectedSpecificFriends);

    if (!(newSelectedSpecificFrineds.contains(friendId))) {
      newSelectedSpecificFrineds.add(friendId);
    } else {
      newSelectedSpecificFrineds.remove(friendId);
    }
    emit(
      state.copyWith(
        selectedSpecificFriends: newSelectedSpecificFrineds,
        getAllFriendStatus: GetAllFriendStatus.init,
      ),
    );
  }
  void toggleSelectionMentionFriends(int friendId) {
    List<int> mentionedListFriends= List.from(state.selectedMentionFriends);

    if (!(mentionedListFriends.contains(friendId))) {
      mentionedListFriends.add(friendId);
    } else {
      mentionedListFriends.remove(friendId);
    }
    emit(
      state.copyWith(
        selectedMentionFriends: mentionedListFriends,
        getAllFriendStatus: GetAllFriendStatus.init,
      ),
    );
  }
  void toggleSelectFriendsExcept(int friendId) {
    List<int> newSelectedFriendsExcept = List.from(state.selectedFriendsExcept);
    if (!(newSelectedFriendsExcept.contains(friendId))) {
      newSelectedFriendsExcept.add(friendId);
    } else {
      newSelectedFriendsExcept.remove(friendId);
    }
    emit(
      state.copyWith(
        selectedFriendsExcept:newSelectedFriendsExcept,
        getAllFriendStatus: GetAllFriendStatus.init,
      ),
    );
  }

  _mapFailureGetFriendsToState(emit, Failure f, PostFriendsState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            getAllFriendStatus: GetAllFriendStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            getAllFriendStatus: GetAllFriendStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}
