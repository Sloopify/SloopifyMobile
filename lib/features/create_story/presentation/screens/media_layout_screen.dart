import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';

import '../widgets/image_item.dart';
import 'media_editor_screen.dart';

enum MediaLayout {
  single,
  twoVertical,
  twoHorizontal,
  threeTop,
  threeLeft,
  fourSquare,
  fiveGrid,
  sixGrid,
}

class MediaLayoutScreen extends StatefulWidget {
  const MediaLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MediaLayoutScreen> createState() => _MediaLayoutScreenState();
}

class _MediaLayoutScreenState extends State<MediaLayoutScreen> {
  MediaLayout _selectedLayout = MediaLayout.single;

  MediaLayout _getRecommendedLayout(int count) {
    switch (count) {
      case 1:
        return MediaLayout.single;
      case 2:
        return MediaLayout.twoVertical;
      case 3:
        return MediaLayout.threeTop;
      case 4:
        return MediaLayout.fourSquare;
      case 5:
        return MediaLayout.fiveGrid;
      case 6:
        return MediaLayout.sixGrid;
      default:
        return MediaLayout.single;
    }
  }

  List<MediaLayout> _getAvailableLayouts(int count) {
    switch (count) {
      case 1:
        return [MediaLayout.single];
      case 2:
        return [MediaLayout.twoVertical, MediaLayout.twoHorizontal];
      case 3:
        return [MediaLayout.threeTop, MediaLayout.threeLeft];
      case 4:
        return [
          MediaLayout.fourSquare,
          MediaLayout.twoVertical,
          MediaLayout.twoHorizontal,
        ];
      case 5:
        return [MediaLayout.fiveGrid, MediaLayout.fourSquare];
      case 6:
        return [MediaLayout.sixGrid, MediaLayout.fiveGrid];
      default:
        return [MediaLayout.single];
    }
  }

  String _getLayoutName(MediaLayout layout) {
    switch (layout) {
      case MediaLayout.single:
        return "Single";
      case MediaLayout.twoVertical:
        return "Two Vertical";
      case MediaLayout.twoHorizontal:
        return "Two Horizontal";
      case MediaLayout.threeTop:
        return "Three Top";
      case MediaLayout.threeLeft:
        return "Three Left";
      case MediaLayout.fourSquare:
        return "Four Square";
      case MediaLayout.fiveGrid:
        return "Five Grid";
      case MediaLayout.sixGrid:
        return "Six Grid";
    }
  }

  void _proceedToEditing() async {
    final cubit = context.read<StoryEditorCubit>();
    final selectedAssets = cubit.state.selectedMedia;

    // Convert selected assets to MediaEntity list with layout information
    final mediaEntities = await cubit.convertToOrderedMediaEntities(
      selectedAssets,
      cubit.state.mediaFiles ?? [],
    );

    // Set the final media list with layout
    cubit.setFinalListOfMediaFiles(mediaEntities);

    // Navigate to editing screen
    if (mounted) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder:
      //         (context) => BlocProvider.value(
      //           value: cubit,
      //           child: MediaEditingScreen(layout: _selectedLayout),
      //         ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Create story - Layout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _proceedToEditing,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<StoryEditorCubit, StoryEditorState>(
        builder: (context, state) {
          final selectedCount = state.selectedMedia.length;
          final availableLayouts = _getAvailableLayouts(selectedCount);

          // Set recommended layout if not already set
          if (!availableLayouts.contains(_selectedLayout)) {
            _selectedLayout = _getRecommendedLayout(selectedCount);
          }

          return Column(
            children: [
              // Preview Area
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _buildLayoutPreview(
                      state.mediaFiles??[],
                      _selectedLayout,
                    ),
                  ),
                ),
              ),

              // Layout Options
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Choose Layout",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: availableLayouts.length,
                        itemBuilder: (context, index) {
                          final layout = availableLayouts[index];
                          final isSelected = layout == _selectedLayout;

                          return GestureDetector(
                            onTap:
                                () => setState(() => _selectedLayout = layout),
                            child: Container(
                              width: 120,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? Colors.teal.withOpacity(0.1)
                                        : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.teal
                                          : Colors.grey[300]!,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  // Layout preview thumbnail
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: _buildLayoutThumbnail(
                                          state.mediaFiles!,
                                          layout,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Layout name
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      _getLayoutName(layout),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            isSelected
                                                ? Colors.teal
                                                : Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLayoutPreview(List<MediaEntity> assets, MediaLayout layout) {
    if (assets.isEmpty) {
      return const Center(child: Text("No media selected"));
    }

    return _buildLayoutGrid(assets, layout, isPreview: true);
  }

  Widget _buildLayoutThumbnail(List<MediaEntity> assets, MediaLayout layout) {
    if (assets.isEmpty) {
      return Container(color: Colors.grey[300]);
    }

    return _buildLayoutGrid(assets, layout, isPreview: false);
  }

  Widget _buildLayoutGrid(
    List<MediaEntity> assets,
    MediaLayout layout, {
    required bool isPreview,
  }) {
    switch (layout) {
      case MediaLayout.single:
        return _buildSingleLayout(assets, );
      case MediaLayout.twoVertical:
        return _buildTwoVerticalLayout(assets, );
      case MediaLayout.twoHorizontal:
        return _buildTwoHorizontalLayout(assets, );
      case MediaLayout.threeTop:
        return _buildThreeTopLayout(assets, );
      case MediaLayout.threeLeft:
        return _buildThreeLeftLayout(assets,);
      case MediaLayout.fourSquare:
        return _buildFourSquareLayout(assets);
      case MediaLayout.fiveGrid:
        return _buildFiveGridLayout(assets);
      case MediaLayout.sixGrid:
        return _buildSixGridLayout(assets);
    }
  }

  Widget _buildSingleLayout(List<MediaEntity> assets,) {
    return ImageWidget(
    mediaEntity:   assets.first,
    );
  }

  Widget _buildTwoVerticalLayout(List<MediaEntity> assets) {
    return Row(
      children: [
        Expanded(
          child: ImageWidget(
            mediaEntity: assets[0]
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: ImageWidget(
           mediaEntity:  assets.length > 1 ? assets[1] : assets[0],
          ),
        ),
      ],
    );
  }

  Widget _buildTwoHorizontalLayout(List<MediaEntity> assets) {
    return Column(
      children: [
        Expanded(
          child: ImageWidget(
           mediaEntity:  assets[0],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: ImageWidget(
            mediaEntity:  assets.length > 1 ? assets[1] : assets[0],

          ),
        ),
      ],
    );
  }

  Widget _buildThreeTopLayout(List<MediaEntity> assets) {
    return Column(
      children: [
        Expanded(
          child: ImageWidget(
          mediaEntity:  assets[0],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: ImageWidget(
                  mediaEntity:   assets.length > 1 ? assets[1] : assets[0],
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                mediaEntity:   assets.length > 2 ? assets[2] : assets[0],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThreeLeftLayout(List<MediaEntity> assets,) {
    return Row(
      children: [
        Expanded(
          child: ImageWidget(
           mediaEntity: assets[0],
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ImageWidget(
                mediaEntity:   assets.length > 1 ? assets[1] : assets[0],
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: ImageWidget(
                 mediaEntity :assets.length > 2 ? assets[2] : assets[0],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFourSquareLayout(List<MediaEntity> assets) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: ImageWidget(
                mediaEntity:   assets[0],
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                 mediaEntity:  assets.length > 1 ? assets[1] : assets[0],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: ImageWidget(
                 mediaEntity:   assets.length > 2 ? assets[2] : assets[0],
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                 mediaEntity:  assets.length > 3 ? assets[3] : assets[0],

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFiveGridLayout(List<MediaEntity> assets) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: ImageWidget(
                 mediaEntity:  assets[0],
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                  mediaEntity:  assets.length > 1 ? assets[1] : assets[0],

                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: ImageWidget(
                mediaEntity:   assets.length > 2 ? assets[2] : assets[0],
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                  mediaEntity:  assets.length > 3 ? assets[3] : assets[0],

                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                  mediaEntity: assets.length > 4 ? assets[4] : assets[0],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSixGridLayout(List<MediaEntity> assets) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: ImageWidget(mediaEntity: assets[0])),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                  mediaEntity: assets.length > 1 ? assets[1] : assets[0],
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                  mediaEntity: assets.length > 2 ? assets[2] : assets[0],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: ImageWidget(
                  mediaEntity: assets.length > 3 ? assets[3] : assets[0],
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                  mediaEntity: assets.length > 4 ? assets[4] : assets[0],
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: ImageWidget(
                  mediaEntity: assets.length > 5 ? assets[5] : assets[0],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
