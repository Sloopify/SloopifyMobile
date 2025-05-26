import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_post_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';

import '../../../../posts/domain/entities/frined_entity.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostState.empty());


  void setPostText(String postText) {
    emit(state.copyWith(
        text: postText, createPostStatus: CreatePostStatus.init));
  }

  void setPostAudience(PostAudience postAudience) {
    emit(state.copyWith(
        postAudience: postAudience, createPostStatus: CreatePostStatus.init));
  }

  void setSearchFriendNameField(String value) {
    emit(state.copyWith(searchFriendName: value));
  }


  void getAllFriends() async {
    emit(state.copyWith(getAllFriendStatus: GetAllFriendStatus.loading));
    await Future.delayed(Duration(seconds: 1));
    List<FriendEntity> allFreinds = [
      FriendEntity(name: "Nour alkhalil",
          id: 1,
          isSent: false,
          profileImge: AssetsManager.manExample2),
      FriendEntity(name: "Fadi",
          id: 2,
          isSent: false,
          profileImge: AssetsManager.manExample2),
      FriendEntity(name: "Ibrahim ",
          id: 3,
          isSent: false,
          profileImge: AssetsManager.manExample2),
      FriendEntity(name: "test ",
          id: 4,
          isSent: false,
          profileImge: AssetsManager.manExample2),
      FriendEntity(name: "test",
          id: 4,
          isSent: false,
          profileImge: AssetsManager.manExample2),
      FriendEntity(name: "dwdwww",
          id: 5,
          isSent: false,
          profileImge: AssetsManager.manExample2),
    ];
    emit(state.copyWith(
        allFriends: allFreinds, getAllFriendStatus: GetAllFriendStatus.success
    ));
  }

  void selectFriendEntity(FriendEntity friend) {
    if (!(state.createPostEntity.friends.contains(friend))) {
      state.createPostEntity.friends.add(friend);
    } else {
      state.createPostEntity.friends.remove(friend);
    }
    emit(state.copyWith(
        friends:  state.createPostEntity.friends, createPostStatus: CreatePostStatus.init));
  }
  void setImages(List<File> files) {
    emit(state.copyWith(
        images: files, createPostStatus: CreatePostStatus.init));
  }
  void setVideos(List<File> files) {
    emit(state.copyWith(
        videos: files, createPostStatus: CreatePostStatus.init));
  }
  void setVideoThumbnail(AssetEntity assetEntity) {
    emit(state.copyWith(
        assetEntity: assetEntity, createPostStatus: CreatePostStatus.init));
  }
}
