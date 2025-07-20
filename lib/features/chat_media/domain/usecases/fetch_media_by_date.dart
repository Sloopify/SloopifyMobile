import 'package:sloopify_mobile/features/chat_media/domain/repository/media_repository.dart';

import '../entities/media_item.dart';

class FetchMediaByDate {
  final MediaRepository repository;

  FetchMediaByDate(this.repository);

  Future<Map<String, List<MediaItem>>> call() {
    return repository.fetchMediaByDate();
  }
}
