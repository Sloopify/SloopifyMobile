part of 'post_freinds_cubit.dart';

enum GetAllFriendStatus { init, loading, success, error, offline }

class PostFriendsState extends Equatable {
  final GetAllFriendStatus getAllFriendStatus;
  final String errorMessage;
  final List<UserEntity> allFriends;
  final List<int> selectedSpecificFriends;
  final List<int> selectedFriendsExcept;
  final List<int> selectedMentionFriends;
  final String searchName;
  final int page;
  final bool hasReachedEnd;

  const PostFriendsState({
    this.getAllFriendStatus = GetAllFriendStatus.init,
    this.errorMessage = "",
    this.allFriends = const [],
    this.searchName = "",
    this.selectedFriendsExcept=const [],
    this.selectedSpecificFriends=const [],
    this.page=0,
    this.hasReachedEnd=true,
    this.selectedMentionFriends=const []

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    getAllFriendStatus,
    errorMessage,
    allFriends,
    searchName,
    selectedFriendsExcept,
    selectedSpecificFriends,
    selectedMentionFriends,
    hasReachedEnd,
    page

  ];

  PostFriendsState copyWith({
    GetAllFriendStatus? getAllFriendStatus,
    String? errorMessage,
    List<UserEntity>? allFriends,
    List<int>? selectedFriends,
    String? searchName,
    bool? isSpecificFriends,
    bool ?isFriendsExcept,
     List<int>? selectedSpecificFriends,
     List<int> ?selectedFriendsExcept,
    List<int>? selectedMentionFriends,
    int? page,
    bool ? hasReachedEnd

  }) {
    return PostFriendsState(
      page: page??this.page,
      hasReachedEnd: hasReachedEnd??this.hasReachedEnd,
      selectedMentionFriends: selectedMentionFriends??this.selectedMentionFriends,
      errorMessage: errorMessage ?? this.errorMessage,
      getAllFriendStatus: getAllFriendStatus ?? this.getAllFriendStatus,
      allFriends: allFriends ?? this.allFriends,
      searchName: searchName ?? this.searchName,
      selectedFriendsExcept: selectedFriendsExcept??this.selectedFriendsExcept,
      selectedSpecificFriends: selectedSpecificFriends??this.selectedSpecificFriends
    );
  }
}
