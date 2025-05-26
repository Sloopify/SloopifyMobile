import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'dart:typed_data';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../data/models/album_model.dart';
import '../blocs/media_selection_cubit/media_selection_cubit.dart';

class CreateAlbumScreen extends StatefulWidget {
  final Function()? updateAfterCreateAlbum;
  final bool toCreateAlbum;

  const CreateAlbumScreen({
    super.key,
    this.updateAfterCreateAlbum,
    this.toCreateAlbum = true,
  });

  @override
  State<CreateAlbumScreen> createState() => _CreateAlbumScreenState();
}

class _CreateAlbumScreenState extends State<CreateAlbumScreen> {
  final List<AssetEntity> _media = [];
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 0;
  bool _isLoading = false;
  final int _pageSize = 60;
  Map<String, Uint8List> _thumbnailCache = {};

  @override
  void initState() {
    super.initState();
    _requestAndLoad();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreMedia();
      }
    });
  }

  Future<void> _requestAndLoad() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      _loadMoreMedia();
    } else {
      await PhotoManager.openSetting();
    }
  }

  Future<void> _loadMoreMedia() async {
    if (_isLoading) return;
    _isLoading = true;

    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.common,
    );
    if (albums.isEmpty) return;

    final recent = albums.first;
    final newAssets = await recent.getAssetListPaged(
      page: _currentPage,
      size: _pageSize,
    );

    if (newAssets.isNotEmpty) {
      setState(() {
        _media.addAll(newAssets);
        _currentPage++;
      });
    }

    _isLoading = false;
  }

  Future<void> createNewAlbum(
    List<AssetEntity> selectedAssets,
    final Function() updateListOfAlbum,
  ) async {
    final box = Hive.box<AlbumModel>('albums');
    final assetIds = selectedAssets.map((a) => a.id).toList();

    final album = AlbumModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      assetIds: assetIds,
    );

    await box.add(album);
    showSnackBar(context, "Album created  ${album.id}");

    Navigator.pop(context);
    updateListOfAlbum();
  }

  Widget _buildGridItem(AssetEntity asset, BuildContext context) {
    final selected = context.watch<MediaSelectionCubit>().state;
    final isSelected = selected.contains(asset);
    final assetId = asset.id;
    return GestureDetector(
      onTap: () async {
        context.read<MediaSelectionCubit>().toggleSelection(asset);
      },
      child: BlocBuilder<MediaSelectionCubit, List<AssetEntity>>(
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
                  child: Icon(
                    Icons.check_circle,
                    color: ColorManager.primaryColor,
                    size: 24,
                  ),
                ),
              if (asset.type == AssetType.video)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<MediaSelectionCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: getCustomAppBar(
              context: context,
              title: widget.toCreateAlbum ? "New album" : "select thumbnail",
            ),
            body: Stack(
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
                if (context.read<MediaSelectionCubit>().state.isNotEmpty)
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
                      child: BlocBuilder<CreatePostCubit, CreatePostState>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                            label:
                                widget.toCreateAlbum
                                    ? "create your album (${context.read<MediaSelectionCubit>().state.length})"
                                    : "Done",
                            onPressed:
                                widget.toCreateAlbum
                                    ? () => createNewAlbum(
                                      context.read<MediaSelectionCubit>().state
                                        ..map((e) => e.id).toList(),
                                      widget.updateAfterCreateAlbum!,
                                    )
                                    : () {
                                      context
                                          .read<MediaSelectionCubit>()
                                          .selectedFilesWithType
                                          .then((value) {
                                            context
                                                .read<CreatePostCubit>()
                                                .setImages(
                                                  value
                                                      .where(
                                                        (e) =>
                                                            e.type ==
                                                            AssetType.image,
                                                      )
                                                      .map((e) => e.file)
                                                      .toList(),
                                                );
                                            context
                                                .read<CreatePostCubit>()
                                                .setVideoThumbnail(
                                                  context
                                                      .read<
                                                        MediaSelectionCubit
                                                      >()
                                                      .state
                                                      .firstWhere(
                                                        (e) =>
                                                            e.type ==
                                                            AssetType.video,
                                                      ),
                                                );
                                          });
                                      Navigator.of(context).pop();
                                    },
                            backgroundColor: ColorManager.primaryColor,
                            width: MediaQuery.of(context).size.width * 0.5,
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
