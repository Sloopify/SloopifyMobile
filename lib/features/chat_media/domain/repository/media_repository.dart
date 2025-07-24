import '../entities/media_item.dart';

abstract class MediaRepository {
  Future<Map<String, List<MediaItem>>> fetchMediaByDate();
}
