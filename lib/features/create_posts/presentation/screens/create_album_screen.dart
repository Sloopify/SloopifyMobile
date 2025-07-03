import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'dart:typed_data';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/edit_media_cubit/edit_media_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';

class AlbumPhotosScreen extends StatefulWidget {
  const AlbumPhotosScreen({super.key});

  static const routeName = "album_photos_screen";

  @override
  State<AlbumPhotosScreen> createState() => _AlbumPhotosScreenState();
}

class _AlbumPhotosScreenState extends State<AlbumPhotosScreen> {
  final List<AssetEntity> _media = [];
  final ScrollController _scrollController = ScrollController();
  final List<AssetPathEntity> _albums = [];
  AssetPathEntity? _selectedAlbum;
  int _currentPage = 0;
  bool _isLoading = false;
  final int _pageSize = 60;
  Map<String, Uint8List> _thumbnailCache = {};
  bool _showAlbums = false;

  @override
  void initState() {
    super.initState();
    _initGallery();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMedia();
      }
    });
  }

  Future<void> _initGallery() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      await PhotoManager.openSetting();
      return;
    }

    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      onlyAll: false,
    );

    if (albums.isNotEmpty) {
      setState(() {
        _albums.addAll(albums);
        _selectedAlbum = _albums.first;
      });
      await _loadMedia();
    }
  }

  Future<void> _loadMedia() async {
    if (_isLoading || _selectedAlbum == null) return;
    _isLoading = true;

    final newMedia = await _selectedAlbum!.getAssetListPaged(
      page: _currentPage,
      size: _pageSize,
    );

    if (newMedia.isNotEmpty) {
      setState(() {
        _media.addAll(newMedia);
        _currentPage++;
      });
    }

    _isLoading = false;
  }

  void _onAlbumChanged(AssetPathEntity album) {
    setState(() {
      _selectedAlbum = album;
      _media.clear();
      _currentPage = 0;
    });
    _loadMedia();
  }

  Widget _buildGridItem(AssetEntity asset, BuildContext context) {
    final selected = context.watch<CreatePostCubit>().state.selectedMedia;
    final isSelected = selected.contains(asset);
    final assetId = asset.id;
    return GestureDetector(
      onTap: () async {
        context.read<CreatePostCubit>().toggleSelection(asset);
      },
      child: BlocBuilder<CreatePostCubit, CreatePostState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child:
                    _thumbnailCache.containsKey(assetId)
                        ? Image.memory(
                          _thumbnailCache[assetId]!,
                          fit: BoxFit.cover,
                        )
                        : FutureBuilder<Uint8List?>(
                          future: asset.thumbnailDataWithSize(
                            ThumbnailSize(200, 200),
                          ),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              _thumbnailCache[assetId] = snapshot.data!;
                              return Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              );
                            }
                            return Container(color: Colors.grey[300]);
                          },
                        ),
              ),
              if (isSelected)
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorManager.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      isSelected
                          ? (context
                                      .read<CreatePostCubit>()
                                      .state
                                      .selectedMedia
                                      .indexOf(asset) +
                                  1)
                              .toString()
                          : 0.toString(),
                      style: AppTheme.bodyText3.copyWith(
                        color: ColorManager.primaryColor,
                      ),
                    ),
                  ),
                ),
              if (asset.type == AssetType.video)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(Icons.videocam, color: ColorManager.white),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: getCustomAppBar(
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 35),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          _selectedAlbum?.name ?? "",
                          style: AppTheme.headline4,
                        ),
                        Gaps.hGap1,
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showAlbums = !_showAlbums;
                            });
                          },
                          child:
                              !_showAlbums
                                  ? Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 25,
                                  )
                                  : Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                    size: 25,
                                  ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.5,
                      color: ColorManager.disActive.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
            context: context,
            title: "Select Photo/Video",
          ),
          body: Stack(
            children: [
              SafeArea(
                child: Stack(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      padding: EdgeInsets.all(4),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemCount: _media.length,
                      itemBuilder:
                          (_, index) => _buildGridItem(_media[index], context),
                    ),
                    if (context
                        .read<CreatePostCubit>()
                        .state
                        .selectedMedia
                        .isNotEmpty)
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
                            onPressed: () async {
                              final previousMediaList =
                                  context
                                      .read<EditMediaCubit>()
                                      .state
                                      .mediaList;
                              final updatedMediaList = context
                                  .read<EditMediaCubit>()
                                  .convertToOrderedMediaEntities(
                                    context
                                        .read<CreatePostCubit>()
                                        .selectedAssets,
                                    previousMediaList,
                                  );

                              context.read<EditMediaCubit>().updateMediaList(
                                await updatedMediaList,
                              );
                              context
                                  .read<CreatePostCubit>()
                                  .setFinalListOfMediaFiles(await updatedMediaList);
                              context.read<CreatePostCubit>().toggleVerticalOption(false);
                              Navigator.of(context).pop();
                              },
                            backgroundColor: ColorManager.primaryColor,
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (_showAlbums)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: ColorManager.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          _albums
                              .map(
                                (e) => InkWell(
                                  onTap: () {
                                    _onAlbumChanged(e);
                                    setState(() {
                                      _showAlbums = !_showAlbums;
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppPadding.p20,
                                      vertical: AppPadding.p10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          e.name,
                                          style: AppTheme.headline4.copyWith(
                                            color: ColorManager.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
