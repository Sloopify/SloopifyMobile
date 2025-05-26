import 'dart:typed_data' show Uint8List;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/album_view.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/create_album_screen.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../data/models/album_model.dart';

class AlbumGridScreen extends StatefulWidget {
  const AlbumGridScreen({super.key});

  @override
  _AlbumGridScreenState createState() => _AlbumGridScreenState();
}

class _AlbumGridScreenState extends State<AlbumGridScreen> {
  late Future<List<Map<String, dynamic>>> _albumsFuture;

  @override
  void initState() {
    super.initState();
    _albumsFuture = loadAlbumsWithThumbnails();
  }

  Future<List<Map<String, dynamic>>> loadAlbumsWithThumbnails() async {
    final box = Hive.box<AlbumModel>('albums');
    final List<AlbumModel> albums = box.values.toList();

    List<Map<String, dynamic>> result = [];

    for (final album in albums) {
      AssetEntity? thumbnail;
      if (album.assetIds.isNotEmpty) {
        thumbnail = await AssetEntity.fromId(
          album.assetIds.last,
        ); // last image/video
      }

      result.add({'album': album, 'thumbnail': thumbnail});
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "My albums"),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _albumsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final albums = snapshot.data!;

          return albums.isEmpty
              ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Albums created yet!",
                      style: AppTheme.headline4.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gaps.vGap3,
                    CustomElevatedButton(
                      label: "Create New album",
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => CreateAlbumScreen(
                                  updateAfterCreateAlbum:(){
                                    setState(() {
                                      _albumsFuture=loadAlbumsWithThumbnails();
                                    });

                                  },
                                ),
                          ),
                        );
                      },
                      width: MediaQuery.of(context).size.width * 0.6,
                      backgroundColor: ColorManager.primaryColor,
                    ),
                  ],
                ),
              )
              : Stack(
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: albums.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final album = albums[index]['album'] as AlbumModel;
                      final thumbnail =
                          albums[index]['thumbnail'] as AssetEntity?;

                      return _buildAlbumTile(album, thumbnail);
                    },
                  ),
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
                        label: "Add new album",
                        onPressed:
                            () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => CreateAlbumScreen(
                                      updateAfterCreateAlbum:(){
                                        setState(() {
                                          _albumsFuture=loadAlbumsWithThumbnails();
                                        });

                                      },
                                    ),
                              ),
                            ),
                        backgroundColor: ColorManager.primaryColor,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }

  Widget _buildAlbumTile(AlbumModel album, AssetEntity? thumbnail) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AlbumDetailScreen(assetIds: album.assetIds),
          ),
        );
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          FutureBuilder<Uint8List?>(
            future: thumbnail?.thumbnailDataWithSize(ThumbnailSize(300, 300)),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.memory(
                    height: 400,
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return Container(color: Colors.grey[300]);
              }
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 75,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: ColorManager.white.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Album#',
                        style: AppTheme.bodyText3.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorManager.primaryColor,
                        ),
                      ),
                      Gaps.vGap1,
                      Text(
                        '${album.assetIds.length}photos',
                        style: AppTheme.bodyText3.copyWith(
                          color: ColorManager.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(AssetsManager.albums),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
