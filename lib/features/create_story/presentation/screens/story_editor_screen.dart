import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/calculate_tempreture_cubit/calculate_temp_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/drawing_story/drawing_story_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/drawing_story/drawing_story_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/editing_top_tool_bar.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/story_elements_sheet.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/story_painter.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/stroke_width_drawer.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/ui/widgets/custom_sheet.dart';
import '../blocs/story_editor_cubit/story_editor_cubit.dart';
import '../widgets/confirm_discard_or_keep_editing_story.dart';
import '../widgets/drawing_color_pallete.dart';
import '../widgets/editable_text_element.dart';
import '../widgets/postitioned_element_item.dart';
import '../widgets/text_input_overlay.dart';

enum EditingMode { normal, draw, text, sticker }

class StoryEditorScreen extends StatefulWidget {
  final MediaEntity media;

  const StoryEditorScreen({Key? key, required this.media}) : super(key: key);

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

  // UI state
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

  @override
  void initState() {
    super.initState();
    context.read<CalculateTempCubit>().getCurrentTemperature();
    _initializeAnimations();
    _initializeMedia();
    _mediaInitialRotationRadians =
        (widget.media.rotateAngle ?? 0.0) * (3.14159 / 180);
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

  void _initializeMedia() async {
    if (widget.media.isVideoFile && widget.media.file != null) {
      _videoController = VideoPlayerController.file(widget.media.file!);
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

  @override
  Widget build(BuildContext context) {
    print(context.read<StoryEditorCubit>().state.positionedElements);
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<DrawingStoryCubit, DrawingState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Media Display
              Positioned.fill(
                child: GestureDetector(
                  onScaleUpdate:
                      _currentMode != EditingMode.draw &&
                              context
                                  .read<TextEditingCubit>()
                                  .state
                                  .allTextAlignment
                                  .isEmpty
                          ? (details) {
                            if (_currentMode != EditingMode.draw) {
                              setState(() {
                                // Update scale
                                _currentScale = _initialScale * details.scale;

                                // Update rotation
                                _currentRotation =
                                    _initialRotation + details.rotation;

                                _currentOffset += details.focalPointDelta;
                              });
                            }
                          }
                          : null,
                  onScaleStart:
                      _currentMode != EditingMode.draw &&
                              context
                                  .read<TextEditingCubit>()
                                  .state
                                  .allTextAlignment
                                  .isEmpty
                          ? (details) {
                            if (_currentMode != EditingMode.draw) {
                              _initialScale = _currentScale;
                              _initialRotation = _currentRotation;
                              _initialOffset = _currentOffset;
                            }
                          }
                          : null,
                  onTap: () {},
                  onPanStart:
                      _currentMode == EditingMode.draw &&
                              context
                                  .read<TextEditingCubit>()
                                  .state
                                  .allTextAlignment
                                  .isEmpty
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
                  child: Container(
                    color: Colors.black,
                    child: Transform.translate(
                      offset: _currentOffset, // Apply translation first
                      child: Transform.rotate(
                        angle: _mediaInitialRotationRadians + _currentRotation,
                        // Combine initial and gesture rotation
                        child: Transform.scale(
                          scale: _currentScale, // Apply scale
                          child: Stack(
                            children: [
                              // Image or Video
                              widget.media.isVideoFile
                                  ? _buildVideoPlayer()
                                  : _buildImageDisplay(),

                              // Drawing Layer
                              if (_currentMode == EditingMode.draw)
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

                              // Display and manipulate the active text element
                              // In the Stack children of the build method
                              ...context
                                  .watch<StoryEditorCubit>()
                                  .state
                                  .positionedElements
                                  .map(
                                    (element) =>
                                        _buildPositionedElement(element),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (context
                  .read<TextEditingCubit>()
                  .state
                  .allTextAlignment
                  .isNotEmpty)
                ...context.read<TextEditingCubit>().state.allTextAlignment.map((
                  e,
                ) {
                  _textKeys.putIfAbsent(e.id, () => GlobalKey());
                  return BlocBuilder<TextEditingCubit, TextEditingState>(
                    builder: (context, state) {
                      return EditableTextElement(
                        widgetKey: _textKeys[e.id]!,
                        textElement: e,
                        onElementChanged: (updatedElement) {
                          print(updatedElement.id);
                          context
                              .read<TextEditingCubit>()
                              .updateSelectedPositionedText(updatedElement.id);
                        },
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
                      return BlocBuilder<StoryEditorCubit, StoryEditorState>(
                        builder: (context, state) {
                          return PositionedElementItem(
                            widgetKey: _elementsKey[e.id]!,
                            onUpdateElement: (element) {
                              context
                                  .read<StoryEditorCubit>()
                                  .updateSelectedPositioned(element.id);

                            },
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
                    _changeEditingMode(EditingMode.normal);
                  },
                  onBack: () {
                    if (_currentMode == EditingMode.draw) {
                      context.read<DrawingStoryCubit>().clearDrawing();
                      _changeEditingMode(EditingMode.normal);
                      _toggleToolbar();
                    } else if (_currentMode == EditingMode.normal) {
                      _toggleToolbar();
                      CustomSheet.show(
                        child: ConfirmDiscardOrKeepEditingStory(),
                        context: context,
                        barrierColor: ColorManager.black.withOpacity(0.2),
                      );
                    } else if (_currentMode == EditingMode.text) {
                      _changeEditingMode(EditingMode.normal);
                      _toggleToolbar();
                    }
                  },
                  undoDrawing: context.read<DrawingStoryCubit>().undoDrawing,
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
                      offset: Offset(0, 100 * (1 - _toolbarAnimation.value)),
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
                        context.read<DrawingStoryCubit>().changeStrokeWidth,
                    currentStrokeWidth: state.strokeWidth,
                  ),
                ),
              // Mode-specific Toolbars
              if (_currentMode == EditingMode.draw) DrawingColorPallete(),
              // Text Editing Overlay (TextField and Text Toolbar)
              if (_currentMode == EditingMode.text)
                TextInputOverlay(
                  onTextSubmitted: () {
                    _changeEditingMode(EditingMode.normal);
                    _toggleToolbar();
                  },
                ),
            ],
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
    return Positioned.fill(
      child: AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: VideoPlayer(_videoController!),
      ),
    );
  }

  Widget _buildImageDisplay() {
    return Positioned.fill(
      child: Image.file(widget.media.file!, fit: BoxFit.contain),
    );
  }

  Widget _buildPositionedElement(dynamic element) {
    // This will be implemented in the next section
    return const SizedBox.shrink();
  }

  Widget _buildSideLeftDrawingToolBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
            _toggleToolbar();
            _changeEditingMode(EditingMode.sticker);
            CustomSheet.show(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<StoryEditorCubit>()),
                  BlocProvider.value(value: context.read<CalculateTempCubit>()),
                  BlocProvider.value(value: context.read<FeelingsActivitiesCubit>()),
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
      ],
    );
  }
}
