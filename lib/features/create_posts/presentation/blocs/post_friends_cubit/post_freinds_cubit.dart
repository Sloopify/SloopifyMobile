import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/use_cases/get_story_friends_use_case.dart';
import 'package:sloopify_mobile/features/create_story/domain/use_cases/search_story_friends_use_case.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/get_friends_list_use_case.dart';
import '../../../domain/use_cases/search_friend_use_case.dart';

part 'post_freinds_state.dart';

class PostFriendsCubit extends Cubit<PostFriendsState> {
  final GetFriendsListUseCase getFriendsListUseCase;
  final SearchFriendsListUseCase searchFriendsListUseCase;
  final GetStoryFriendsUseCase getStoryFriendsUseCase;
  final SearchStoryFriendsUseCase searchStoryFriendsUseCase;

  PostFriendsCubit({
    required this.getFriendsListUseCase,
    required this.searchFriendsListUseCase,
    required this.searchStoryFriendsUseCase,
    required this.getStoryFriendsUseCase,
  }) : super(PostFriendsState());
  final RefreshController refreshController = RefreshController();

  setSearchFriendName(String value) {
    emit(
      state.copyWith(
        searchName: value,
        getAllFriendStatus: GetAllFriendStatus.loading,
      ),
    );
  }

  setFromStory() {
    emit(state.copyWith(fromStory: true));
  }

  getFriendsList({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          page: 1,
          hasReachedEnd: false,
          allFriends: [],
          getAllFriendStatus: GetAllFriendStatus.loading,
        ),
      );
    }
    final res =
        state.fromStory
            ? await getStoryFriendsUseCase.call(page: state.page, perPage: 10)
            : await getFriendsListUseCase.call(perPage: 10, page: state.page);
    res.fold(
      (l) {
        refreshController.loadFailed();
        _mapFailureGetFriendsToState(emit, l, state);
      },
      (r) {
        final newList = [...state.allFriends, ...r.friends];
        emit(
          state.copyWith(
            allFriends: newList,
            page: state.page + 1,
            hasReachedEnd: !r.paginationData.hasMorePages,
            getAllFriendStatus: GetAllFriendStatus.success,
          ),
        );

        if (r.paginationData.hasMorePages) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      },
    );
  }

  void onLoadMore() {
    if (!state.hasReachedEnd) {
      state.searchName.isEmpty
          ? getFriendsList(isLoadMore: true)
          : searchFriendsList(isLoadMore: true);
    } else {
      refreshController.loadNoData();
    }
  }

  void onRefresh() async {
    emit(state.copyWith(page: 1, allFriends: [], hasReachedEnd: false));
    state.searchName.isEmpty ? getFriendsList() : searchFriendsList();
    refreshController.refreshCompleted();
  }

  searchFriendsList({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          page: 1,
          hasReachedEnd: false,
          allFriends: [],
          getAllFriendStatus: GetAllFriendStatus.loading,
        ),
      );
    }
    final res =
        state.fromStory
            ? await searchStoryFriendsUseCase.call(
              friendName: state.searchName,
              page: state.page,
              perPage: 10,
            )
            : await searchFriendsListUseCase.call(
              friendName: state.searchName,
              page: state.page,
              perPage: 10,
            );
    res.fold(
      (l) {
        _mapFailureGetFriendsToState(emit, l, state);
        refreshController.loadFailed();
      },
      (r) {
        final newList = [...state.allFriends, ...r.friends];

        emit(
          state.copyWith(
            allFriends: newList,
            page: state.page + 1,
            hasReachedEnd: !r.paginationData.hasMorePages,
            getAllFriendStatus: GetAllFriendStatus.success,
          ),
        );

        if (r.paginationData.hasMorePages) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      },
    );
  }

  void toggleSelectSpecificFriends(int friendId) {
    List<int> newSelectedSpecificFrineds = List.from(
      state.selectedSpecificFriends,
    );

    if (!(newSelectedSpecificFrineds.contains(friendId))) {
      newSelectedSpecificFrineds.add(friendId);
    } else {
      newSelectedSpecificFrineds.remove(friendId);
    }
    emit(state.copyWith(selectedSpecificFriends: newSelectedSpecificFrineds));
  }

  void toggleSelectionMentionFriends(int friendId) {
    List<int> mentionedListFriends = List.from(state.selectedMentionFriends);

    if (!(mentionedListFriends.contains(friendId))) {
      mentionedListFriends.add(friendId);
    } else {
      mentionedListFriends.remove(friendId);
    }
    emit(state.copyWith(selectedMentionFriends: mentionedListFriends));
  }

  void toggleSelectionMentionStoryFriends(MentionFriendStory mention) {
    List<MentionFriendStory> mentionedListFriends = List.from(state.mentionFriendsStory);

    if (!(mentionedListFriends.contains(mention))) {
      mentionedListFriends.add(mention);
    } else {
      mentionedListFriends.remove(mention);
    }
    emit(state.copyWith(mentionFriendStory: mentionedListFriends));
  }

  void toggleSelectFriendsExcept(int friendId) {
    List<int> newSelectedFriendsExcept = List.from(state.selectedFriendsExcept);
    if (!(newSelectedFriendsExcept.contains(friendId))) {
      newSelectedFriendsExcept.add(friendId);
    } else {
      newSelectedFriendsExcept.remove(friendId);
    }
    emit(state.copyWith(selectedFriendsExcept: newSelectedFriendsExcept));
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

  void emptyMentionFriends(){
    emit(state.copyWith(mentionFriendStory: []));
  }
}
