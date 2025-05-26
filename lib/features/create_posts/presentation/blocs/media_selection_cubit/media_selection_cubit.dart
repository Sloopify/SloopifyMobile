import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../domain/entities/selected_file_entity.dart';

class MediaSelectionCubit extends Cubit<List<AssetEntity>> {
  MediaSelectionCubit() : super([]);

  void toggleSelection(AssetEntity asset) {
    final updated = List<AssetEntity>.from(state);
    if (updated.contains(asset)) {
      updated.remove(asset);
    } else {
      updated.add(asset);
    }
    emit(updated);
  }

  void clearSelection() => emit([]);

  List<AssetEntity> get selectedAssets => state;

  Future<List<SelectedMediaFile>> get selectedFilesWithType async {
    final list = <SelectedMediaFile>[];

    for (final asset in state) {
      final file = await asset.file;
      if (file != null) {
        list.add(SelectedMediaFile(file: file, type: asset.type));
      }
    }

    return list;
  }
}