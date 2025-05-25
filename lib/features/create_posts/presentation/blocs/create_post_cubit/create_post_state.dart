part of 'create_post_cubit.dart';

enum CreatePostStatus { init, loading, success, error, offline }
enum GetAllFriendStatus { init, loading, success, error, offline }

class CreatePostState extends Equatable {
  final CreatePostEntity createPostEntity;
  final CreatePostStatus createPostStatus;
  final List<FriendEntity> allFriends;
  final String searchFriendName;
  final GetAllFriendStatus getAllFriendStatus;

  CreatePostState({
    required this.createPostStatus,
    required this.createPostEntity,
    required this.allFriends,
    required this.searchFriendName,
    required this.getAllFriendStatus
  });

  @override
  // TODO: implement props
  List<Object?> get props => [createPostStatus, createPostEntity,allFriends,searchFriendName,getAllFriendStatus];

  factory CreatePostState.empty() {
    return CreatePostState(
      getAllFriendStatus: GetAllFriendStatus.init,
      searchFriendName: '',
      allFriends: [],
      createPostStatus: CreatePostStatus.init,
      createPostEntity: CreatePostEntity.fromEmpty(),
    );
  }

  CreatePostState copyWith({
    String? text,
    String? feelings,
    bool? is24Hours,
    List<File>? images,
    List<File>? videos,
    List<FriendEntity>? friends,
    List<FriendEntity>? mentions,
    double? latitude,
    double? longtitude,
    List<String>? activities,
    PostAudience?postAudience,
    CreatePostStatus? createPostStatus,
    List<FriendEntity>? allFriends,
    String? searchFriendName,
    GetAllFriendStatus? getAllFriendStatus,
  }) {
    return CreatePostState(
      getAllFriendStatus: getAllFriendStatus??this.getAllFriendStatus,
      searchFriendName: searchFriendName??this.searchFriendName,
      allFriends: allFriends??this.allFriends,
      createPostStatus: createPostStatus ?? this.createPostStatus,
      createPostEntity: createPostEntity.copyWith(
        postAudience: postAudience??createPostEntity.postAudience,
        text: text??createPostEntity.text,
        activities: activities??createPostEntity.activities,
        feelings: feelings??createPostEntity.feelings,
        friends: friends??createPostEntity.friends,
        images: images??createPostEntity.images,
        is24Hours: is24Hours??createPostEntity.is24Hours,
        latitude: latitude??createPostEntity.latitude,
        longtitude: longtitude??createPostEntity.longtitude,
        mentions: mentions??createPostEntity.mentions,
        videos: videos??createPostEntity.videos,


      ),
    );
  }
}
