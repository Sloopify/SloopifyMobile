import 'package:sloopify_mobile/features/chat_media/domain/entities/media_item.dart';

class MediaModel extends MediaItem {
  MediaModel({required super.imagePath});

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(imagePath: json['imagePath']);
  }

  Map<String, dynamic> toJson() {
    return {'imagePath': imagePath};
  }
}
