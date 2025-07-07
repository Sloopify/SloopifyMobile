import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class MediaEntity extends Equatable {
  final File? file;
  final int? order;
  final bool? autoPlay;
  final bool? applyToDownload;
  final bool? isRotate;
  final double? rotateAngle;
  final bool? isFlipHorizontal;
  final bool? isFlipVertical;
  final String? filterName;
  final bool isVideoFile;
  final String id;

  const MediaEntity({
    required this.file,
    this.applyToDownload,
    this.autoPlay,
    this.filterName,
    this.isFlipHorizontal,
    this.isFlipVertical,
    this.isRotate,
    required this.order,
    required this.isVideoFile,
    this.rotateAngle,
    required this.id,
  });

  factory MediaEntity.fromEmpty() {
    return MediaEntity(
      id: "",
      isVideoFile: false,
      file: null,
      applyToDownload: null,
      autoPlay: null,
      filterName: null,
      isFlipHorizontal: false,
      isFlipVertical: false,
      isRotate: null,
      order: null,
      rotateAngle: 0.0,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    file,
    applyToDownload,
    autoPlay,
    filterName,
    isFlipHorizontal,
    isFlipVertical,
    isRotate,
    rotateAngle,
    order,
    isVideoFile,
    id,
  ];

  MediaEntity copyWith({
    File? file,
    int? order,
    bool? autoPlay,
    bool? applyToDownload,
    bool? isRotate,
    double? rotateAngle,
    bool? isFlipHorizontal,
    bool? isFlipVertical,
    String? filterName,
    bool? isVideoFile,
  }) {
    return MediaEntity(
      file: file ?? this.file,
      applyToDownload: applyToDownload ?? this.applyToDownload,
      autoPlay: autoPlay ?? this.autoPlay,
      filterName: filterName ?? this.filterName,
      isFlipHorizontal: isFlipHorizontal ?? this.isFlipHorizontal,
      isFlipVertical: isFlipVertical ?? this.isFlipVertical,
      isRotate: isRotate ?? this.isRotate,
      order: order ?? this.order,
      isVideoFile: isVideoFile ?? this.isVideoFile,
      rotateAngle: rotateAngle ?? this.rotateAngle,
      id: id,
    );
  }

  toJson() async {
    Map<String, dynamic> data = <String, dynamic>{};
   if(order!=null)   data.putIfAbsent('order', () => order);
    if (applyToDownload != null && isVideoFile) data.putIfAbsent('apply_to_download', () => boolToInt(applyToDownload));
    if (autoPlay != null && isVideoFile) data.putIfAbsent('auto_play', () => boolToInt(autoPlay));
    if (isRotate != null ) data.putIfAbsent('is_rotate', () => boolToInt(isRotate));
    if (rotateAngle != null ) data.putIfAbsent('rotate_angle', () => rotateAngle);
    if (isFlipHorizontal != null ) data.putIfAbsent('is_flip_horizontal', () => boolToInt(isFlipHorizontal));
    if (isFlipVertical != null ) data.putIfAbsent('is_flip_vertical', () => boolToInt(isFlipHorizontal));
    if (filterName != null ) data.putIfAbsent('filter_name', () => filterName);
    if (file != null) {
      data['file'] = await MultipartFile.fromFile(file!.path);
    }
    return data;
  }

  int boolToInt(bool? value) => (value ?? false) ? 1 : 0;
}
