import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectedMediaFile  extends Equatable{
  final File file;
  final AssetType type;

 const SelectedMediaFile({required this.file, required this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [file,type];
}