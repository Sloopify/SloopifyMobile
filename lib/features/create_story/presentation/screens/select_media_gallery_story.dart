import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_editor_screen.dart';
import 'dart:typed_data';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../core/utils/helper/snackbar.dart';
import '../blocs/calculate_tempreture_cubit/calculate_temp_cubit.dart';
import '../blocs/drawing_story/drawing_story_cubit.dart';
import '../blocs/text_editing_cubit/text_editing_cubit.dart';

class SelectMediaGalleryStory extends StatefulWidget {
  final bool isMultiSelection;

  const SelectMediaGalleryStory({super.key, this.isMultiSelection = true});

  static const routeName = "select_media_galley";

  @override
  State<SelectMediaGalleryStory> createState() =>
      _SelectMediaGalleryStoryState();
}

class _SelectMediaGalleryStoryState extends State<SelectMediaGalleryStory> {
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
      type:widget.isMultiSelection?RequestType.image: RequestType.all,
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
    final selected = context.watch<StoryEditorCubit>().state.selectedMedia;
    final isSelected = selected.contains(asset);
    final assetId = asset.id;
    return GestureDetector(
      onTap: () async {
        if (widget.isMultiSelection) {
          context.read<StoryEditorCubit>().toggleSelection(asset);
        } else {
          await context.read<StoryEditorCubit>().selectOneMedia(asset);
          print(  context.read<StoryEditorCubit>().state.mediaFiles);
          Navigator.of(context).pushNamed(StoryEditorScreen.routeName,arguments: {
            "story_editor_cubit":context.read<StoryEditorCubit>(),
            "post_friends_cubit":context.read<PostFriendsCubit>(),
            "add_location_cubit":context.read<AddLocationCubit>(),
            "feelings_activities_cubit":context.read<FeelingsActivitiesCubit>(),
          });
        }
      },
      child: BlocBuilder<StoryEditorCubit, StoryEditorState>(
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
              if (widget.isMultiSelection)
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected?ColorManager.primaryColor:ColorManager.white,
                      border: Border.all(
                        color: ColorManager.primaryColor,
                        width: 2,
                      ),
                    ),
                    child:
                        isSelected
                            ? Text(
                              isSelected
                                  ? (context
                                              .read<StoryEditorCubit>()
                                              .state
                                              .selectedMedia
                                              .indexOf(asset) +
                                          1)
                                      .toString()
                                  : 0.toString(),
                              style: AppTheme.bodyText3.copyWith(
                                color: ColorManager.white,
                              ),
                            )
                            : SizedBox.shrink(),
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
    return widget.isMultiSelection
        ? Scaffold(
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
                        .read<StoryEditorCubit>()
                        .state
                        .selectedMedia
                        .isNotEmpty)
                      SafeArea(
                        child: Align(
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
                                        .read<StoryEditorCubit>()
                                        .state
                                        .mediaFiles;
                                final updatedMediaList = context
                                    .read<StoryEditorCubit>()
                                    .convertToOrderedMediaEntities(
                                      context
                                          .read<StoryEditorCubit>()
                                          .state
                                          .selectedMedia,
                                      previousMediaList ?? [],
                                    );
                                context
                                    .read<StoryEditorCubit>()
                                    .setFinalListOfMediaFiles(
                                      await updatedMediaList,
                                    );
                                Navigator.of(context).pushNamed(StoryEditorScreen.routeName,arguments: {
                                  "story_editor_cubit":context.read<StoryEditorCubit>(),
                                  "post_friends_cubit":context.read<PostFriendsCubit>(),
                                  "add_location_cubit":context.read<AddLocationCubit>(),
                                  "feelings_activities_cubit":context.read<FeelingsActivitiesCubit>(),
                                });
                              },
                              backgroundColor: ColorManager.primaryColor,
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
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
        )
        : GridView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          padding: EdgeInsets.all(4),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: _media.length,
          itemBuilder: (_, index) => _buildGridItem(_media[index], context),
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
