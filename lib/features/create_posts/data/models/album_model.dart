// album_model.dart
import 'package:hive/hive.dart';

part 'album_model.g.dart';

@HiveType(typeId: 0)
class AlbumModel extends HiveObject {
  @HiveField(0)
  String id;


  @HiveField(2)
  List<String> assetIds;

  AlbumModel({required this.id,  required this.assetIds});
}