import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoGalleryScreen extends StatefulWidget {
  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  List<AssetEntity> _images = [];
  List<AssetEntity> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      List<AssetEntity> photos = await albums[0].getAssetListPaged( page: 0,size: 100);
      setState(() {
        _images = photos;
      });
    } else {
      PhotoManager.openSetting();
    }
  }

  void _toggleSelection(AssetEntity image) {
    setState(() {
      if (_selectedImages.contains(image)) {
        _selectedImages.remove(image);
      } else {
        _selectedImages.add(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Do something with _selectedImages
            },
          )
        ],
      ),
      body: Column(
        children: [
          if (_selectedImages.isNotEmpty)
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length,
                itemBuilder: (_, index) {
                  return FutureBuilder<Uint8List?>(
                    future: _selectedImages[index].thumbnailDataWithSize(ThumbnailSize(100, 100)),
                    builder: (_, snapshot) {
                      final bytes = snapshot.data;
                      return bytes != null
                          ? Padding(
                        padding: EdgeInsets.all(4),
                        child: Image.memory(bytes),
                      )
                          : SizedBox();
                    },
                  );
                },
              ),
            ),
          Expanded(
            child: GridView.builder(
              itemCount: _images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (_, index) {
                final image = _images[index];
                return GestureDetector(
                  onTap: () => _toggleSelection(image),
                  child: Stack(
                    children: [
                      FutureBuilder<Uint8List?>(
                        future: image.thumbnailDataWithSize(ThumbnailSize(200, 200)),
                        builder: (_, snapshot) {
                          final bytes = snapshot.data;
                          return bytes != null
                              ? Image.memory(bytes, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                              : Container();
                        },
                      ),
                      if (_selectedImages.contains(image))
                        Positioned(
                          top: 5,
                          right: 5,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 12,
                            child: Icon(Icons.check, size: 16, color: Colors.white),
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}