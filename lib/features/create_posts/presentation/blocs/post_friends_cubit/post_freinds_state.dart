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

  const PostFriendsState({
    this.getAllFriendStatus = GetAllFriendStatus.init,
    this.errorMessage = "",
    this.allFriends = const [],
    this.searchName = "",
    this.selectedFriendsExcept=const [],
    this.selectedSpecificFriends=const [],
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
    selectedMentionFriends

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

  }) {
    return PostFriendsState(
      selectedMentionFriends: selectedMentionFriends??this.selectedMentionFriends,
      errorMessage: errorMessage ?? this.errorMessage,
      getAllFriendStatus: getAllFriendStatus ?? this.getAllFriendStatus,
      allFriends: allFriends ?? this.allFriends,
      searchName: searchName ?? this.searchName,
      selectedFriendsExcept: selectedSpecificFriends??this.selectedSpecificFriends,
      selectedSpecificFriends: selectedSpecificFriends??this.selectedSpecificFriends
    );
  }
}
