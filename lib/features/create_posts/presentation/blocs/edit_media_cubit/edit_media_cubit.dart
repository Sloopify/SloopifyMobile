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
              id: selectedAssets[i].id,
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
  Future<List<AssetEntity>> getSelectedAssetEntitiesFromMediaList() async {
    final List<String> assetIdsToFetch = [];

    // Collect all unique asset IDs from the current mediaList
    for (final mediaEntity in state.mediaList) {
      assetIdsToFetch.add(mediaEntity.id!);
        }

    if (assetIdsToFetch.isEmpty) {
      return []; // No asset IDs to fetch
    }

    try {
      // Fetch AssetEntity objects by their IDs
      final List<AssetEntity?> fetchedAssets =
      await PhotoManager.getAssetListPaged(page:0,pageCount: 100 );

      // Filter out nulls and return valid AssetEntity objects
      // Maintain the order based on the original mediaList if needed,
      // but for pre-selection, just having them is enough.
      final List<AssetEntity> result = [];
      for (final id in assetIdsToFetch) {
        final asset = fetchedAssets.firstWhere((element) => element?.id == id, orElse: () => null);
        if (asset != null) {
          result.add(asset);
        }
      }
      return result;
    } catch (e) {
      print("Error fetching AssetEntities from MediaList: $e");
      return [];
    }
  }
  void addFilterEffect(int index,File? filterImage) {
   state.mediaList[index].copyWith(file: filterImage);
    emit(state.copyWith(mediaList: state.mediaList));
  }

}
