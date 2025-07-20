import 'package:sloopify_mobile/features/chat_media/domain/repository/media_repository.dart';

import '../../domain/entities/media_item.dart';
import '../datasources/media_local_datasource.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaLocalDataSource localDataSource;

  MediaRepositoryImpl(this.localDataSource);

  @override
  Future<Map<String, List<MediaItem>>> fetchMediaByDate() async {
    final raw = await localDataSource.getGroupedMedia();

    return {
      for (var entry in raw.entries)
        entry.key:
            entry.value.map((m) => MediaItem(imagePath: m.imagePath)).toList(),
    };
  }
}
