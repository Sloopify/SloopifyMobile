import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/media_story.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/positioned_element_entity.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/calculate_tempreture_cubit/calculate_temp_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/drawing_story/drawing_story_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/drawing_story/drawing_story_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/editing_top_tool_bar.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/interactive_media_item.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/post_story_btn.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/story_elements_sheet.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/story_painter.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/stroke_width_drawer.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/ui/widgets/custom_sheet.dart';
import '../blocs/story_editor_cubit/story_editor_cubit.dart';
import '../widgets/confirm_discard_or_keep_editing_story.dart';
import '../widgets/drawing_color_pallete.dart';
import '../widgets/dynamic_layout.dart';
import '../widgets/editable_text_element.dart';
import '../widgets/postitioned_element_item.dart';
import '../widgets/story_privacy_fab.dart';
import '../widgets/text_input_overlay.dart';

enum EditingMode { normal, draw, text, sticker,dragging }

class StoryEditorScreen extends StatefulWidget {
  const StoryEditorScreen({Key? key}) : super(key: key);
  static const routeName = " story_editor_screen";

  @override
  State<StoryEditorScreen> createState() => _StoryEditorScreenState();
}

class _StoryEditorScreenState extends State<StoryEditorScreen>
    with TickerProviderStateMixin {
  // Controllers
  VideoPlayerController? _videoController;
  late AnimationController _toolbarAnimationController;
  late Animation<double> _toolbarAnimation;

  // Editing state
  EditingMode _currentMode = EditingMode.normal;

  bool _isToolbarVisible = true;

  // New state variables for multi-touch transformations
  double _currentScale = 1.0;
  double _currentRotation = 0.0; // in radians
  Offset _currentOffset = Offset.zero; // For panning/translation

  // Variables to store the state at the start of a gesture
  double _initialScale = 1.0;
  double _initialRotation = 0.0;
  Offset _initialOffset = Offset.zero;
  late double _mediaInitialRotationRadians;
  final Map<String, GlobalKey> _textKeys = {};
  final Map<String, GlobalKey> _elementsKey = {};
  late FocusNode _textFocusNode;

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    //context.read<CalculateTempCubit>().getCurrentTemperature();
    _initializeAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeVideoMedia(context);
    });
  }

  void _initializeAnimations() {
    _toolbarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _toolbarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _toolbarAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    _toolbarAnimationController.forward();
  }

  void _initializeVideoMedia(BuildContext context) async {
    final cubit = context.read<StoryEditorCubit>();
    final List<MediaStory> medias = cubit.state.mediaFiles ?? [];
    if (medias.first.isVideoFile && medias.first.file != null) {
      _videoController = VideoPlayerController.file(medias.first.file!);
      await _videoController!.initialize();
      _videoController!.setLooping(true);
      _videoController!.play();
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _toolbarAnimationController.dispose();

    super.dispose();
  }

  void _toggleToolbar() {
    setState(() {
      _isToolbarVisible = !_isToolbarVisible;
    });
    if (_isToolbarVisible) {
      _toolbarAnimationController.forward();
    } else {
      _toolbarAnimationController.reverse();
    }
  }

  void _changeEditingMode(EditingMode mode) {
    setState(() {
      _currentMode = mode;
    });
  }

  void _applyCenteredGridLayout() {
    final mediaFiles = context.read<StoryEditorCubit>().state.mediaFiles ?? [];
    if (mediaFiles.isEmpty) return;

    final screenSize = MediaQuery.of(context).size;
    const itemSize = 180.0;
    const spacing = 12.0;

    // Calculate max items per row
    final itemsPerRow = (screenSize.width / (itemSize + spacing)).floor();
    final rowCount = (mediaFiles.length / itemsPerRow).ceil();

    // Total width of the grid (to center horizontally)
    final totalGridWidth =
        (itemsPerRow * itemSize) + ((itemsPerRow - 1) * spacing);
    final horizontalOffset = (screenSize.width - totalGridWidth) / 2;

    // Total height of the grid (to center vertically)
    final totalGridHeight = (rowCount * itemSize) + ((rowCount - 1) * spacing);
    final verticalOffset = (screenSize.height - totalGridHeight) / 2;

    final updatedMediaFiles = <MediaStory>[];

    for (int i = 0; i < mediaFiles.length; i++) {
      final row = i ~/ itemsPerRow;
      final col = i % itemsPerRow;

      final dx = horizontalOffset + col * (itemSize + spacing);
      final dy = verticalOffset + row * (itemSize + spacing);

      final updatedMedia = mediaFiles[i].copyWith(offset: Offset(dx, dy));
      updatedMediaFiles.add(updatedMedia);
    }

    context.read<StoryEditorCubit>().setFinalListOfMediaFiles(
      updatedMediaFiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          _currentMode == EditingMode.normal
              ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10,
                  vertical: AppPadding.p10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [StoryPrivacyFab(), PostStoryBtn()],
                ),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.black,
      body: BlocBuilder<DrawingStoryCubit, DrawingState>(
        builder: (context, state) {
          return BlocBuilder<StoryEditorCubit, StoryEditorState>(
            builder: (context, storyState) {
              final mediaFiles = storyState.mediaFiles ?? [];
              print(mediaFiles.map((e) => e.offset));
              if (mediaFiles.length > 1 && mediaFiles.isNotEmpty) {
                // Apply dynamic layout when media files change
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mediaFiles.isNotEmpty && mediaFiles.length > 1) {
                    // Check if layout needs to be applied (items without positions)
                    final needsLayout = mediaFiles.any(
                      (item) =>
                          item.offset == null ||
                          item.scale == null ||
                          item.offset == Offset.zero,
                    );
                    if (needsLayout) {
                      _applyCenteredGridLayout();
                    }
                  }
                });
                return GestureDetector(
                  onPanStart:
                      _currentMode == EditingMode.draw
                          ? (details) {
                            context.read<DrawingStoryCubit>().changeCurrentLine(
                              [details.localPosition],
                            );
                          }
                          : null,
                  onPanUpdate:
                      _currentMode == EditingMode.draw
                          ? (details) {
                            context.read<DrawingStoryCubit>().addNewLine(
                              details.localPosition,
                            );
                          }
                          : null,
                  onPanEnd:
                      _currentMode == EditingMode.draw
                          ? (details) {
                            context
                                .read<DrawingStoryCubit>()
                                .addDrawingElement();
                            context
                                .read<DrawingStoryCubit>()
                                .emptyCurrentPoints();
                          }
                          : null,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      ...storyState.mediaFiles!.asMap().entries.map((entry) {
                        return InteractiveMediaItem(media: entry.value);
                      }),
                      if (context
                          .read<TextEditingCubit>()
                          .state
                          .allTextAlignment
                          .isNotEmpty)
                        ...context
                            .read<TextEditingCubit>()
                            .state
                            .allTextAlignment
                            .map((e) {
                              _textKeys.putIfAbsent(e.id, () => GlobalKey());
                              return BlocBuilder<
                                TextEditingCubit,
                                TextEditingState
                              >(
                                builder: (context, state) {
                                  print(
                                    state.allTextAlignment.map((e) => e.text),
                                  );
                                  return EditableTextElement(
                                    onScale: (){},
                                    onTap: () {
                                      context
                                          .read<TextEditingCubit>()
                                          .setEditingExistingText(true);
                                      _changeEditingMode(EditingMode.text);
                                    },
                                    widgetKey: _textKeys[e.id]!,
                                    textElement: e,
                                  );
                                },
                              );
                            }),
                      if (context
                          .read<StoryEditorCubit>()
                          .state
                          .positionedElements
                          .isNotEmpty)
                        ...context
                            .read<StoryEditorCubit>()
                            .state
                            .positionedElements
                            .map((e) {
                              _elementsKey.putIfAbsent(e.id, () => GlobalKey());
                              return BlocBuilder<
                                StoryEditorCubit,
                                StoryEditorState
                              >(
                                builder: (context, state) {
                                  return PositionedElementItem(
                                    widgetKey: _elementsKey[e.id]!,
                                    positionedElement: e,
                                  );
                                },
                              );
                            }),
                      // Top Toolbar
                      Positioned(
                        top: MediaQuery.of(context).padding.top,
                        left: 0,
                        right: 0,
                        child: EditingTopToolBar(
                          editingMode: _currentMode,
                          onDone: () {
                            context.read<StoryEditorCubit>().addTextElement(
                              newElement:
                                  context
                                      .read<TextEditingCubit>()
                                      .state
                                      .allTextAlignment,
                            );
                            _changeEditingMode(EditingMode.normal);
                            _toggleToolbar();
                          },
                          onBack: () {
                            if (_currentMode == EditingMode.draw) {
                              context.read<DrawingStoryCubit>().clearDrawing();
                              _changeEditingMode(EditingMode.normal);
                              _toggleToolbar();
                            } else {
                              CustomSheet.show(
                                child: MultiBlocProvider(
                                  providers: [
                                    BlocProvider.value(
                                      value: context.read<StoryEditorCubit>(),
                                    ),
                                    BlocProvider.value(
                                      value: context.read<TextEditingCubit>(),
                                    ),
                                    BlocProvider.value(
                                      value: context.read<DrawingStoryCubit>(),
                                    ),
                                  ],
                                  child: ConfirmDiscardOrKeepEditingStory(),
                                ),
                                context: context,
                                barrierColor: ColorManager.black.withOpacity(
                                  0.2,
                                ),
                              );
                            }
                          },
                          undoDrawing:
                              context.read<DrawingStoryCubit>().undoDrawing,
                        ),
                      ),
                      // Bottom Toolbar
                      AnimatedBuilder(
                        animation: _toolbarAnimation,
                        builder: (context, child) {
                          return Positioned(
                            top: MediaQuery.of(context).padding.top + 100,
                            left: 15,
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                100 * (1 - _toolbarAnimation.value),
                              ),
                              child: Opacity(
                                opacity: _toolbarAnimation.value,
                                child: _buildSideLeftDrawingToolBar(context),
                              ),
                            ),
                          );
                        },
                      ),
                      if (_currentMode == EditingMode.draw)
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 100,
                          right: 0,
                          child: StrokeWidthDrawer(
                            onChanged:
                                context
                                    .read<DrawingStoryCubit>()
                                    .changeStrokeWidth,
                            currentStrokeWidth: state.strokeWidth,
                          ),
                        ),
                      // Mode-specific Toolbars
                      if (_currentMode == EditingMode.draw)
                        DrawingColorPallete(),
                      // Text Editing Overlay (TextField and Text Toolbar)
                      if (_currentMode == EditingMode.text)
                        TextInputOverlay(
                          focusNode: _textFocusNode,
                          onTextSubmitted: () {
                            _changeEditingMode(EditingMode.normal);
                            _toggleToolbar();
                          },
                        ),
                      //_buildPostStoryBtn(),
                    ],
                  ),
                );
              } else if (mediaFiles.isNotEmpty && mediaFiles.length == 1) {
                return Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onScaleUpdate:
                            _currentMode != EditingMode.draw
                                ? (details) {
                                  if (_currentMode != EditingMode.draw) {
                                    setState(() {
                                      // Update scale
                                      _currentScale =
                                          _initialScale * details.scale;

                                      // Update rotation
                                      _currentRotation =
                                          _initialRotation + details.rotation;

                                      _currentOffset += details.focalPointDelta;
                                    });
                                  }
                                }
                                : null,
                        onScaleStart:
                            _currentMode != EditingMode.draw
                                ? (details) {
                                  if (_currentMode != EditingMode.draw) {
                                    _initialScale = _currentScale;
                                    _initialRotation = _currentRotation;
                                    _initialOffset = _currentOffset;
                                    context
                                        .read<StoryEditorCubit>()
                                        .onUpdateAttributeOneMedia(
                                          _currentScale,
                                          _currentOffset,
                                          _currentRotation,
                                        );
                                  }
                                }
                                : null,
                        onPanStart:
                            _currentMode == EditingMode.draw &&
                                    context
                                        .read<TextEditingCubit>()
                                        .state
                                        .allTextAlignment
                                        .isEmpty
                                ? (details) {
                                  context
                                      .read<DrawingStoryCubit>()
                                      .changeCurrentLine([
                                        details.localPosition,
                                      ]);
                                }
                                : null,
                        onPanUpdate:
                            _currentMode == EditingMode.draw
                                ? (details) {
                                  context.read<DrawingStoryCubit>().addNewLine(
                                    details.localPosition,
                                  );
                                }
                                : null,
                        onPanEnd:
                            _currentMode == EditingMode.draw
                                ? (details) {
                                  context
                                      .read<DrawingStoryCubit>()
                                      .addDrawingElement();
                                  context
                                      .read<StoryEditorCubit>()
                                      .addDrawingElement(state.lines);
                                  context
                                      .read<DrawingStoryCubit>()
                                      .emptyCurrentPoints();
                                }
                                : null,
                        child: Stack(
                          children: [
                            Container(
                              color: Colors.black,
                              child: Center(
                                child: Transform.translate(
                                  offset: _currentOffset,
                                  // Apply translation first
                                  child: Transform.rotate(
                                    angle: _currentRotation,
                                    // Combine initial and gesture rotation
                                    child: Transform.scale(
                                      scale: _currentScale,
                                      // Apply scale
                                      child:
                                          mediaFiles.first.isVideoFile
                                              ? _buildVideoPlayer()
                                              : _buildImageDisplay(
                                                mediaFiles.first.file!,
                                              ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: CustomPaint(
                                painter: StoryPainter(
                                  drawingPaths:
                                      state.lines +
                                      [
                                        if (state.currentPoints.isNotEmpty)
                                          DrawingElement(
                                            points: state.currentPoints,
                                            color: state.lineColor,
                                            strokeWidth: state.strokeWidth,
                                          ),
                                      ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (context
                        .read<TextEditingCubit>()
                        .state
                        .allTextAlignment
                        .isNotEmpty)
                      ...context
                          .read<TextEditingCubit>()
                          .state
                          .allTextAlignment
                          .map((e) {
                            _textKeys.putIfAbsent(e.id, () => GlobalKey());
                            return BlocBuilder<
                              TextEditingCubit,
                              TextEditingState
                            >(
                              builder: (context, state) {
                                print(
                                  state.allTextAlignment.map((e) => e.text),
                                );
                                return EditableTextElement(
                                  onScale: (){},
                                  onTap: () {
                                    context
                                        .read<TextEditingCubit>()
                                        .setEditingExistingText(true);
                                    _changeEditingMode(EditingMode.text);
                                  },
                                  widgetKey: _textKeys[e.id]!,
                                  textElement: e,
                                );
                              },
                            );
                          }),
                    if (context
                        .read<StoryEditorCubit>()
                        .state
                        .positionedElements
                        .isNotEmpty)
                      ...context
                          .read<StoryEditorCubit>()
                          .state
                          .positionedElements
                          .map((e) {
                            _elementsKey.putIfAbsent(e.id, () => GlobalKey());
                            return BlocBuilder<
                              StoryEditorCubit,
                              StoryEditorState
                            >(
                              builder: (context, state) {
                                return Draggable<PositionedElement>(
                                  data: e,
                                  feedback: PositionedElementItem(
                                    widgetKey: _elementsKey[e.id]!,
                                    positionedElement: e,
                                  ),
                                  child: PositionedElementItem(
                                    widgetKey: _elementsKey[e.id]!,
                                    positionedElement: e,
                                  ),
                                );
                              },
                            );
                          }),
                    // Top Toolbar
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: EditingTopToolBar(
                        editingMode: _currentMode,
                        onDone: () {
                          _changeEditingMode(EditingMode.normal);
                          _toggleToolbar();
                        },
                        onBack: () {
                          if (_currentMode == EditingMode.draw) {
                            context.read<DrawingStoryCubit>().clearDrawing();
                            _changeEditingMode(EditingMode.normal);
                            _toggleToolbar();
                          } else if (_currentMode == EditingMode.normal) {
                            _toggleToolbar();
                            CustomSheet.show(
                              child: MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: context.read<StoryEditorCubit>(),
                                  ),
                                  BlocProvider.value(
                                    value: context.read<TextEditingCubit>(),
                                  ),
                                  BlocProvider.value(
                                    value: context.read<DrawingStoryCubit>(),
                                  ),
                                ],
                                child: ConfirmDiscardOrKeepEditingStory(),
                              ),
                              context: context,
                              barrierColor: ColorManager.black.withOpacity(0.2),
                            );
                          } else if (_currentMode == EditingMode.text) {
                            _changeEditingMode(EditingMode.normal);
                            _toggleToolbar();
                          }
                        },
                        undoDrawing:
                            context.read<DrawingStoryCubit>().undoDrawing,
                      ),
                    ),
                    // Bottom Toolbar
                    AnimatedBuilder(
                      animation: _toolbarAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: MediaQuery.of(context).padding.top + 100,
                          left: 15,
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              100 * (1 - _toolbarAnimation.value),
                            ),
                            child: Opacity(
                              opacity: _toolbarAnimation.value,
                              child: _buildSideLeftDrawingToolBar(context),
                            ),
                          ),
                        );
                      },
                    ),
                    if (_currentMode == EditingMode.draw)
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 100,
                        right: 0,
                        child: StrokeWidthDrawer(
                          onChanged:
                              context
                                  .read<DrawingStoryCubit>()
                                  .changeStrokeWidth,
                          currentStrokeWidth: state.strokeWidth,
                        ),
                      ),
                    // Mode-specific Toolbars
                    if (_currentMode == EditingMode.draw) DrawingColorPallete(),
                    // Text Editing Overlay (TextField and Text Toolbar)
                    if (_currentMode == EditingMode.text)
                      TextInputOverlay(
                        focusNode: _textFocusNode,
                        onTextSubmitted: () {
                          _changeEditingMode(EditingMode.normal);
                          _toggleToolbar();
                        },
                      ),
                  ],
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
    return Stack(
      children: [
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Icon(
            _videoController!.value.isPlaying ? Icons.play_arrow : Icons.pause,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildImageDisplay(File file) {
    return Image.file(file, fit: BoxFit.contain);
  }

  Widget _buildSideLeftDrawingToolBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (context.read<StoryEditorCubit>().state.mediaFiles != null &&
            context.read<StoryEditorCubit>().state.mediaFiles!.length == 1)
          IconButton(
            onPressed: () {
              _changeEditingMode(EditingMode.draw);
              _toggleToolbar();
            },
            icon: Icon(Icons.brush, color: ColorManager.white, size: 24),
          ),
        Gaps.vGap2,
        InkWell(
          onTap: () {
            //    _toggleToolbar();
            _changeEditingMode(EditingMode.sticker);
            CustomSheet.show(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<StoryEditorCubit>()),
                  BlocProvider.value(value: context.read<CalculateTempCubit>()),
                  BlocProvider.value(
                    value: context.read<FeelingsActivitiesCubit>(),
                  ),
                  BlocProvider.value(value: context.read<AddLocationCubit>()),
                ],
                child: StoryElementsSheet(),
              ),
              context: context,
              barrierColor: ColorManager.black.withOpacity(0.2),
            );
          },
          child: SvgPicture.asset(AssetsManager.sticker),
        ),
        Gaps.vGap4,
        InkWell(
          onTap: () {
            _changeEditingMode(EditingMode.text);
            _toggleToolbar();
          },
          child: SvgPicture.asset(AssetsManager.textAa),
        ),
        Gaps.vGap4,

        if (context.read<StoryEditorCubit>().state.mediaFiles!.any(
          (e) => e.isVideoFile,
        ))
          InkWell(
            onTap: () {
              context.read<StoryEditorCubit>().toggleVideoMute();
              _videoController!.setVolume(
                context.read<StoryEditorCubit>().state.isVideoMuted ? 0 : 1,
              );
            },
            child:
                context.read<StoryEditorCubit>().state.isVideoMuted
                    ? Icon(Icons.volume_mute, color: ColorManager.white)
                    : SvgPicture.asset(AssetsManager.muteVideo),
          ),
      ],
    );
  }
  Widget _removeElementWidget(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragTarget<PositionedElement>(
        onWillAcceptWithDetails: (_) => true,
        onAcceptWithDetails: (element) {
          Future.delayed(Duration(milliseconds: 300),(){
            context.read<StoryEditorCubit>().removePositionedElement((element as PositionedElement).id);

          });
          // Optionally: trigger an animation before removal
        },
        builder: (context, candidateData, rejectedData) {
          final isActive = candidateData.isNotEmpty;
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 100,
            width: 100,
            margin: EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
              color: isActive ? Colors.redAccent : Colors.black54,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.delete, color: Colors.white, size: isActive ? 36 : 28),
          );
        },
      ),
    );
  }
}
