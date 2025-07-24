import 'package:sloopify_mobile/features/chat_media/data/models/media_model.dart';

abstract class MediaLocalDataSource {
  Future<Map<String, List<MediaModel>>> getGroupedMedia();
}

class FakeMediaLocalDataSource implements MediaLocalDataSource {
  @override
  Future<Map<String, List<MediaModel>>> getGroupedMedia() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'Today': List.generate(
        6,
        (i) =>
            MediaModel(imagePath: 'assets/images/friendlist/media${i + 3}.jpg'),
      ),
      'Week ago': List.generate(
        4,
        (i) =>
            MediaModel(imagePath: 'assets/images/friendlist/media${i + 3}.jpg'),
      ),
      'Last month': List.generate(
        3,
        (i) => MediaModel(
          imagePath: 'assets/images/friendlist/media${i + 10}.jpg',
        ),
      ),
    };
  }
}
