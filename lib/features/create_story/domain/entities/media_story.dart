import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class MediaStory extends Equatable {
  final File? file;
  final int? order;
  final bool isVideoFile;
  final String? id;
  final double? rotateAngle;
  final double ?scale;
  final Offset? offset;
  final bool ? isVideoMuted;

  const MediaStory({
     this.offset,
     this.scale,
     this.id,
     this.file,
     required this.isVideoFile,
     this.rotateAngle,
     this.order,
    this.isVideoMuted
  });

  factory MediaStory.empty(){
    return MediaStory(offset: Offset.zero,
        scale: 1.0,
        id: '',
        file: null,
        isVideoFile: false,
        rotateAngle: 0.0,
        order: 0);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [offset,scale,id,file,isVideoFile,rotateAngle,order];

  toJson() async {
    Map<String, dynamic> data = <String, dynamic>{};
    if(order!=null)   data.putIfAbsent('order', () => order);
    if (isVideoMuted != null && isVideoFile) data.putIfAbsent('isVideoMuted', () => boolToInt(isVideoMuted));
    if (rotateAngle != null ) data.putIfAbsent('rotate_angle', () => rotateAngle);
    if (scale != null ) data.putIfAbsent('scale', () => scale);
    if(offset!=null){
      data.putIfAbsent('dx', ()=>offset!.dx);
      data.putIfAbsent('dy', ()=>offset!.dy);
    }
    if (file != null) {
      data['file'] = await MultipartFile.fromFile(file!.path);
    }
    return data;
  }

  int boolToInt(bool? value) => (value ?? false) ? 1 : 0;

}
