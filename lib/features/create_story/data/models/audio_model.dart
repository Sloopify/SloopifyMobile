import 'package:sloopify_mobile/features/create_story/domain/entities/audio_entity.dart';

class AudioModel extends AudioEntity {
  const AudioModel({
    required super.id,
    required super.name,
    required super.image,
    required super.duration,
    required super.durationFormatted,
    required super.fileName,
    required super.fileSize,
    required super.fileSizeFormatted,
    required super.fileUrl,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json["id"],
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      duration: json["duration"] ?? 0,
      durationFormatted: json["duration_formatted"] ?? "",
      fileName: json["filename"] ?? "",
      fileSize: json["file_size"] ?? 0,
      fileSizeFormatted: json["file_size_formatted"],
      fileUrl: json["file_url"],
    );
  }
}
