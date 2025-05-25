import 'package:photo_manager/photo_manager.dart';

class CustomAlbum {
  final String id;
  final String name;
  final List<String> assetIds;
  final List<AssetEntity> assets;

  CustomAlbum({required this.id, required this.name, required this.assetIds,required this.assets});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'assetIds': assetIds,
    "assets":assets,
  };

  factory CustomAlbum.fromMap(Map<String, dynamic> map) => CustomAlbum(
    id: map['id'],
    name: map['name'],
    assets: List<AssetEntity>.from(map["assets"]),
    assetIds: List<String>.from(map['assetIds']),
  );
}