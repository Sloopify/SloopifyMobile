import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/text_editor_widget.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/regular_post_entity.dart';

import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostState.empty());

  void setPostText(postText) {
    emit(
      state.copyWith(
        content: postText,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setPostTextBold(bool isBold) {
    emit(
      state.copyWith(isBold: isBold, createPostStatus: CreatePostStatus.init),
    );
  }

  void setPostTextUnderLine(bool isUnderLine) {
    emit(
      state.copyWith(
        isUnderLine: isUnderLine,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setPostTextItalic(bool isItalic) {
    emit(
      state.copyWith(
        isItalic: isItalic,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setVerticalHorizontalOption(bool value) {
    emit(
      state.copyWith(
        showVerticalOption: value,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setTextColor(String? color) {
    emit(state.copyWith(color: color, createPostStatus: CreatePostStatus.init));
  }

  void setBackGroundGradiant(GradientBackground gradiant) {
    emit(
      state.copyWith(
        backGroundColor: gradientToArray(gradiant),
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setPostAudience(PostAudience postAudience) {
    emit(
      state.copyWith(
        postAudience: postAudience,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setFriendsExcept(List<int> value) {
    emit(
      state.copyWith(
        friendsExcept: value,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setSpecificFriends(List<int> value) {
    emit(
      state.copyWith(
        specificFriends: value,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setMentionFriends(List<int> value) {
    emit(
      state.copyWith(friends: value, createPostStatus: CreatePostStatus.init),
    );
  }

  void toggleVerticalOption(bool value) {
    emit(state.copyWith(showVerticalOption: value));
  }

  void setFeelingName(String value) {
    emit(
      state.copyWith(feeling: value, createPostStatus: CreatePostStatus.init),
    );
  }

  void setActivityName(String value) {
    emit(
      state.copyWith(activity: value, createPostStatus: CreatePostStatus.init),
    );
  }

  Future<void> setSelectedMedia(List<AssetEntity> files) async {
    emit(
      state.copyWith(
        selectedMedia: files,
        createPostStatus: CreatePostStatus.init,
      ),
    );
    emit(state.copyWith(mediaFiles: await _getMediaEntitiesFromAssets(files)));
  }

  void toggleSelection(AssetEntity asset) {
    final updated = List<AssetEntity>.from(state.selectedMedia);
    if (updated.contains(asset)) {
      updated.remove(asset);
    } else {
      updated.add(asset);
    }
    emit(state.copyWith(selectedMedia: updated));
  }

  void clearSelection() => emit(state.copyWith(selectedMedia: []));

  List<AssetEntity> get selectedAssets => state.selectedMedia;

  Future<List<File>> getFilesFromAssets(List<AssetEntity> assets) async {
    final files = await Future.wait(
      assets.map((asset) => asset.file).whereType<Future<File?>>(),
    );

    // Filter out nulls just in case some assets fail to resolve to files
    return files.whereType<File>().toList();
  }

  Future<List<MediaEntity>> _getMediaEntitiesFromAssets(
    List<AssetEntity> assets,
  ) async {
    final List<MediaEntity> mediaList = [];

    for (int i = 0; i < assets.length; i++) {
      final file = await assets[i].file;
      if (file == null) continue;

      mediaList.add(
        MediaEntity(
          file: file,
          order: i + 1,
          isVideoFile: assets[i].type == AssetType.video,
        ),
      );
    }

    return mediaList;
  }

  List<String> gradientToArray(GradientBackground gradient) {
    return [
      '#${gradient.startColor.value.toRadixString(16).padLeft(8, '0')}',
      '#${gradient.endColor.value.toRadixString(16).padLeft(8, '0')}',
    ];
  }
}
