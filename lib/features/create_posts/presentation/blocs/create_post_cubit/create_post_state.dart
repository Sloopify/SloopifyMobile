part of 'create_post_cubit.dart';

enum CreatePostStatus { init, loading, success, error, offline }


class CreatePostState extends Equatable {
  final RegularPostEntity regularPostEntity;
  final CreatePostStatus createPostStatus;
  final bool showVerticalOption;
  final List<AssetEntity> selectedMedia;

  CreatePostState({
    required this.createPostStatus,
    required this.regularPostEntity,
    required this.showVerticalOption,
    required this.selectedMedia,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    createPostStatus,
    regularPostEntity,
    showVerticalOption,
    selectedMedia,
  ];

  factory CreatePostState.empty() {
    return CreatePostState(
      showVerticalOption: true,
      selectedMedia: [],
      createPostStatus: CreatePostStatus.init,
      regularPostEntity: RegularPostEntity.empty(),
    );
  }

  CreatePostState copyWith({
    String? content,
    bool? isBold,
    bool? isItalic,
    bool? isUnderLine,
    String? color,
    List<int>? friends,
    int? placeId,
    String? activity,
    String? feeling,
    List<String>? backGroundColor,
    bool? disappears24h,
    PostAudience? postAudience,
    List<int>? friendsExcept,
    List<int>? specificFriends,
    CreatePostStatus? createPostStatus,
    List<UserEntity>? allFriends,
    String? searchFriendName,
    List<AssetEntity>? selectedMedia,
    bool? showVerticalOption,
    List<MediaEntity>? mediaFiles,

  }) {
    return CreatePostState(
      showVerticalOption: showVerticalOption ?? this.showVerticalOption,
      selectedMedia: selectedMedia ?? this.selectedMedia,
      createPostStatus: createPostStatus ?? this.createPostStatus,
      regularPostEntity: regularPostEntity.copyWith(
        color: color ?? regularPostEntity.textPropertyEntity.color,
        isUnderLine:
            isUnderLine ?? regularPostEntity.textPropertyEntity.isUnderLine,
        isItalic: isItalic ?? regularPostEntity.textPropertyEntity.isItalic,
        isBold: isBold ?? regularPostEntity.textPropertyEntity.isBold,
        friends: friends ?? regularPostEntity.mention?.friends,
        activity: activity ?? regularPostEntity.mention?.activity,
        feeling: feeling ?? regularPostEntity.mention?.feeling,
        placeId: placeId ?? regularPostEntity.mention?.placeId,
        postAudience: postAudience ?? regularPostEntity.postAudience,
        backGroundColor: backGroundColor ?? regularPostEntity.backGroundColor,
        content: content ?? regularPostEntity.content,
        disappears24h: disappears24h ?? regularPostEntity.disappears24h,
        friendsExcept: friendsExcept ?? regularPostEntity.friendsExcept,
        updatedMediaFiles: mediaFiles ?? regularPostEntity.mediaFiles,
        specificFriends: specificFriends ?? regularPostEntity.specificFriends,
      ),
    );
  }
  CreatePostState copyWithEditedMedia({
    required int index,
    bool? isRotate,
    double? rotateAngle,
    bool? isFlipHorizontal,
    bool? isFlipVertical,
    String? filterName,
    bool? autoPlay,
    bool? applyToDownload,
  }) {
    if (index < 0 || index >= regularPostEntity.mediaFiles!.length) return this;

    final updatedList = List<MediaEntity>.from(regularPostEntity.mediaFiles!);
    final media = updatedList[index];

    updatedList[index] = media.copyWith(
      isRotate: isRotate ?? media.isRotate,
      rotateAngle: rotateAngle ?? media.rotateAngle,
      isFlipHorizontal: isFlipHorizontal ?? media.isFlipHorizontal,
      isFlipVertical: isFlipVertical ?? media.isFlipVertical,
      filterName: filterName ?? media.filterName,
      autoPlay: autoPlay ?? media.autoPlay,
      applyToDownload: applyToDownload ?? media.applyToDownload,
    );

    return copyWith(mediaFiles: updatedList);
  }
}
