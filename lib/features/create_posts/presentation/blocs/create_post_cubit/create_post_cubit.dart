import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/text_editor_widget.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/regular_post_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/create_post_use_case.dart';

import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';

import '../../../../../core/errors/failures.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final CreatePostUseCase createPostUseCase;

  CreatePostCubit({required this.createPostUseCase})
    : super(CreatePostState.empty());

  createRegularPost() async {
    emit(state.copyWith(createPostStatus: CreatePostStatus.loading));
    final res = await createPostUseCase.call(
      regularPostEntity: state.regularPostEntity,
    );
    res.fold(
      (l) {
        _mapFailureCreatePostToState(emit, l, state);
      },
      (r) {
        emit(state.copyWith(createPostStatus: CreatePostStatus.success));
      },
    );
  }

  void setPostText(postText) {
    emit(
      state.copyWith(
        content: postText,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }

  void setPostAvailableFor24Hours() {
    emit(
      state.copyWith(
        disappears24h: !state.regularPostEntity.disappears24h,
        createPostStatus: CreatePostStatus.init,
      ),
    );
  }
  void setLocationId(int placeId) {
    emit(
      state.copyWith(
        placeId: placeId,
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

  void setFinalListOfMediaFiles(List<MediaEntity> media) {
    emit(state.copyWith(mediaFiles: media));
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
          order: i,
          isVideoFile: assets[i].type == AssetType.video,
        ),
      );
    }

    return mediaList;
  }

  convertToMediaEntity(int orderIndex) async {
    List<MediaEntity>? media =
        state.regularPostEntity.mediaFiles
            ?.map((e) => e.copyWith(order: orderIndex))
            .toList();
    emit(state.copyWith(mediaFiles: media));
  }

  List<String> gradientToArray(GradientBackground gradient) {
    String formatColor(Color color) {
      // Mask out the alpha (top 8 bits) and convert to 6-character hex
      String hex = (color.value & 0x00FFFFFF).toRadixString(16).padLeft(6, '0');
      return '#$hex';
    }

    return [
      formatColor(gradient.startColor),
      formatColor(gradient.endColor),
    ];
  }

  _mapFailureCreatePostToState(emit, Failure f, CreatePostState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            createPostStatus: CreatePostStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            createPostStatus: CreatePostStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}
