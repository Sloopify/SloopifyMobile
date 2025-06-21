import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../domain/entities/media_entity.dart';

part 'edit_media_state.dart';

class EditMediaCubit extends Cubit<EditMediaState> {
  EditMediaCubit(List<MediaEntity> initialMedia)
    : super(EditMediaState(mediaList: initialMedia));

  void updateMedia(int index, MediaEntity updatedEntity) {
    final newList = [...state.mediaList];
    newList[index] = updatedEntity;
    emit(state.copyWith(mediaList: newList));
  }

  void deleteMedia(MediaEntity media) {
    final newList = [...state.mediaList];
    newList.remove(media);
    emit(state.copyWith(mediaList: newList));
  }

  Future<Uint8List?> generateVideoThumbnail(File videoFile) async {
    final Uint8List? thumbnailBytes = await VideoThumbnail.thumbnailData(
      video: videoFile.path,
      imageFormat: ImageFormat.PNG,
      maxWidth: 600, // Adjust as needed
      quality: 75,
    );

    return thumbnailBytes;
  }

  void updateMediaList(List<MediaEntity> media) {
    emit(state.copyWith(mediaList: media));
  }

  Future<List<MediaEntity>> convertToOrderedMediaEntities(
    List<AssetEntity> selectedAssets,
    List<MediaEntity> previousEntities,
  ) async {
    final List<MediaEntity> result = [];

    for (int i = 0; i < selectedAssets.length; i++) {
      final asset = selectedAssets[i];
      final file = await asset.file;

      // Try to preserve previous editing info if exists
      final existing = previousEntities.firstWhere(
        (e) => e.file?.path == file?.path,
        orElse:
            () => MediaEntity(
              file: file!,
              order: i + 1,
              isVideoFile: asset.type == AssetType.video,
            ),
      );

      final updated = existing.copyWith(file: file, order: i + 1);

      result.add(updated);
    }

    return result;
  }
  void addFilterEffect(int index,File? filterImage) {
   state.mediaList[index].copyWith(file: filterImage);
    emit(state.copyWith(mediaList: state.mediaList));
  }

}
