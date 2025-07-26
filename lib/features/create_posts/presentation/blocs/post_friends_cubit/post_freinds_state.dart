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
  final bool fromStory;
  final List<MentionFriendStory> mentionFriendsStory;

  const PostFriendsState({
    this.getAllFriendStatus = GetAllFriendStatus.init,
    this.errorMessage = "",
    this.allFriends = const [],
    this.searchName = "",
    this.selectedFriendsExcept = const [],
    this.selectedSpecificFriends = const [],
    this.page = 0,
    this.hasReachedEnd = true,
    this.selectedMentionFriends = const [],
    this.fromStory = false,
    this.mentionFriendsStory = const [],
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
    page,
    fromStory,
    mentionFriendsStory,
  ];

  PostFriendsState copyWith({
    GetAllFriendStatus? getAllFriendStatus,
    String? errorMessage,
    List<UserEntity>? allFriends,
    List<int>? selectedFriends,
    String? searchName,
    bool? isSpecificFriends,
    bool? isFriendsExcept,
    List<int>? selectedSpecificFriends,
    List<int>? selectedFriendsExcept,
    List<int>? selectedMentionFriends,
    int? page,
    bool? hasReachedEnd,
    bool? fromStory,
    int? selectedMentionFriendId,
    String? selectedMentionName,
    List<MentionFriendStory>? mentionFriendStory,
  }) {
    return PostFriendsState(
      page: page ?? this.page,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      selectedMentionFriends:
          selectedMentionFriends ?? this.selectedMentionFriends,
      errorMessage: errorMessage ?? this.errorMessage,
      getAllFriendStatus: getAllFriendStatus ?? this.getAllFriendStatus,
      allFriends: allFriends ?? this.allFriends,
      searchName: searchName ?? this.searchName,
      selectedFriendsExcept:
          selectedFriendsExcept ?? this.selectedFriendsExcept,
      selectedSpecificFriends:
          selectedSpecificFriends ?? this.selectedSpecificFriends,
      fromStory: fromStory ?? this.fromStory,
      mentionFriendsStory: mentionFriendStory ?? this.mentionFriendsStory,
    );
  }
}

class MentionFriendStory extends Equatable {
  final int friendId;
  final String friendName;

  MentionFriendStory({required this.friendId, required this.friendName});

  @override
  // TODO: implement props
  List<Object?> get props => [friendId, friendName];

  MentionFriendStory copyWith({int? friendId, String? friendName}) {
    return MentionFriendStory(
      friendId: friendId ?? this.friendId,
      friendName: friendName ?? this.friendName,
    );
  }
}
