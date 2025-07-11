import 'package:equatable/equatable.dart';

class AudioEntity extends Equatable {
  final int id;
  final String name;
  final String fileName;
  final String fileUrl;
  final num duration;
  final String durationFormatted;
  final int fileSize;
  final String fileSizeFormatted;
  final String image;

  const AudioEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.duration,
    required this.durationFormatted,
    required this.fileName,
    required this.fileSize,
    required this.fileSizeFormatted,
    required this.fileUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    image,
    duration,
    durationFormatted,
    durationFormatted,
    fileName,
    fileSize,
    fileSizeFormatted,
    fileUrl,
  ];
}
