import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';

class AlbumDetailScreen extends StatefulWidget {
  final List<String> assetIds;

  const AlbumDetailScreen({super.key, required this.assetIds});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  List<AssetEntity> assets = [];
  Set<String> selectedAssetIds = {};

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  Future<void> loadAssets() async {
    final result = await Future.wait(
      widget.assetIds.map((id) => AssetEntity.fromId(id)),
    );
    assets = result.whereType<AssetEntity>().toList();
    setState(() {});
  }

  void toggleSelection(String id) {
    setState(() {
      if (selectedAssetIds.contains(id)) {
        selectedAssetIds.remove(id);
      } else {
        selectedAssetIds.add(id);
      }
    });
  }

  Future<void> uploadSelectedFiles() async {
    final selectedAssets =
        assets.where((a) => selectedAssetIds.contains(a.id)).toList();

    for (final asset in selectedAssets) {
      final file = await asset.file;
      if (file != null) {
        await uploadFile(file);
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Uploaded ${selectedAssets.length} files")),
    );
  }

  Future<void> uploadFile(File file) async {
    // Simulate upload or implement real API call
    final fileName = file.path.split("/").last;
    print("Uploading: $fileName");
    // Upload logic here (http, dio, firebase, etc.)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: "Album Review",
        actions: [
          if (selectedAssetIds.isNotEmpty)
            IconButton(
              icon: Icon(Icons.cloud_upload),
              onPressed: uploadSelectedFiles,
            ),
        ],
      ),
      body:
          assets.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: assets.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final asset = assets[index];
                      final isSelected = selectedAssetIds.contains(asset.id);

                      return GestureDetector(
                        onTap: () => toggleSelection(asset.id),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Positioned.fill(
                              child: FutureBuilder<Uint8List?>(
                                future: asset.thumbnailDataWithSize(
                                  ThumbnailSize(200, 200),
                                ),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return Container(color: Colors.grey[300]);
                                  }
                                },
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 4,
                                left: 4,
                                child: Icon(
                                  Icons.check_box,
                                  color: ColorManager.primaryColor,
                                  size: 30,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  if(selectedAssetIds.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p50,
                        vertical: AppPadding.p8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 6,
                            color: ColorManager.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: CustomElevatedButton(
                        label: "Done",
                        onPressed: () =>Navigator.of(context).pop(),
                        backgroundColor: ColorManager.primaryColor,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
