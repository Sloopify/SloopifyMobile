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
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
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
import 'package:sloopify_mobile/features/create_story/presentation/widgets/text_editing_tool_bar.dart';
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

enum EditingMode { normal, draw, text, sticker, dragging }

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
    print(
      context.read<StoryEditorCubit>().state.mediaFiles!.map((e) => e.offset),
    );
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
  void didChangeDependencies() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _initializeVideoMedia(context);
  });
  super.didChangeDependencies();
  }
  @override
  void dispose() {
    _videoController?.dispose();
    _toolbarAnimationController.dispose();

    super.dispose();
  }

  void _toggleToolbar() {
    if (_currentMode == EditingMode.normal) {
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

  void _applyCenteredGridLayout(BuildContext context) {
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
    print(updatedMediaFiles.map((e) => e.offset));

    context.read<StoryEditorCubit>().setFinalListOfMediaFiles(
      updatedMediaFiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryEditorCubit, StoryEditorState>(
      builder: (context, state) {
        if (_currentMode == EditingMode.normal &&state.mediaFiles!=null&&
            state.mediaFiles!.any(
              (element) =>
                  element.offset == null ||
                  element.offset == Offset.zero ||
                  element.scale == null ||
                  element.rotateAngle == null,
            )) {
          _applyCenteredGridLayout(context);
        }
        return WillPopScope(
          onWillPop: () {
            CustomSheet.show(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<StoryEditorCubit>()),
                  BlocProvider.value(value: context.read<TextEditingCubit>()),
                  BlocProvider.value(value: context.read<DrawingStoryCubit>()),
                ],
                child: ConfirmDiscardOrKeepEditingStory(),
              ),
              context: context,
              barrierColor: ColorManager.black.withOpacity(0.2),
            );
            return Future.value(true);
          },
          child: Scaffold(
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            backgroundColor: Colors.black,
            body:
                state.mediaFiles!.length > 1
                    ? SafeArea(
                      child:
                          _currentMode == EditingMode.dragging
                              ? BlocBuilder<StoryEditorCubit, StoryEditorState>(
                                builder: (context, state) {
                                  if (state.mediaFiles!.any(
                                    (element) =>
                                        element.offset == null ||
                                        element.offset == Offset.zero ||
                                        element.scale == null ||
                                        element.rotateAngle == null,
                                  )) {
                                    _applyCenteredGridLayout(context);
                                  }
                                  return Stack(
                                    fit: StackFit.passthrough,
                                    children: [
                                      Positioned.fill(
                                        child: GestureDetector(
                                          onTap:
                                              () => _changeEditingMode(
                                                EditingMode.normal,
                                              ),
                                        ),
                                      ),
                                      ...state.mediaFiles!.asMap().entries.map((
                                        entry,
                                      ) {
                                        return InteractiveMediaItem(
                                          media: entry.value,
                                          onScale:
                                              () => _changeEditingMode(
                                                EditingMode.dragging,
                                              ),
                                        );
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
                                              _textKeys.putIfAbsent(
                                                e.id,
                                                () => GlobalKey(),
                                              );
                                              return BlocBuilder<
                                                TextEditingCubit,
                                                TextEditingState
                                              >(
                                                builder: (context, state) {
                                                  print(
                                                    state.allTextAlignment.map(
                                                      (e) => e.text,
                                                    ),
                                                  );
                                                  return EditableTextElement(
                                                    onDelete: () {
                                                      context
                                                          .read<
                                                            TextEditingCubit
                                                          >()
                                                          .removeTextElement(
                                                            e.id,
                                                          );
                                                      context
                                                          .read<
                                                            StoryEditorCubit
                                                          >()
                                                          .removeTextElement(
                                                            e.id,
                                                          );
                                                    },
                                                    onScale:
                                                        () => _changeEditingMode(
                                                          EditingMode.dragging,
                                                        ),
                                                    onTap: () {
                                                      context
                                                          .read<
                                                            TextEditingCubit
                                                          >()
                                                          .setEditingExistingText(
                                                            true,
                                                          );
                                                      _changeEditingMode(
                                                        EditingMode.text,
                                                      );
                                                    },
                                                    widgetKey: _textKeys[e.id]!,
                                                    textElement: e,
                                                  );
                                                },
                                              );
                                            }),
                                      if (state.positionedElements.isNotEmpty)
                                        ...state.positionedElements.map((e) {
                                          _elementsKey.putIfAbsent(
                                            e.id,
                                            () => GlobalKey(),
                                          );
                                          return BlocBuilder<
                                            StoryEditorCubit,
                                            StoryEditorState
                                          >(
                                            builder: (context, state) {
                                              return PositionedElementItem(
                                                onScale: ()=>_changeEditingMode(EditingMode.dragging),
                                                onDelete: () {
                                                  context
                                                      .read<StoryEditorCubit>()
                                                      .removePositionedElement(
                                                        e.id,
                                                      );
                                                },
                                                widgetKey: _elementsKey[e.id]!,
                                                positionedElement: e,
                                              );
                                            },
                                          );
                                        }),
                                    ],
                                  );
                                },
                              )
                              : _currentMode == EditingMode.draw
                              ? Stack(
                                fit: StackFit.passthrough,
                                children: [
                                  Positioned.fill(
                                    child: GestureDetector(
                                      onPanStart: (details) {
                                        context
                                            .read<DrawingStoryCubit>()
                                            .changeCurrentLine([
                                              details.localPosition,
                                            ]);
                                      },

                                      onPanUpdate: (details) {
                                        context
                                            .read<DrawingStoryCubit>()
                                            .addNewLine(details.localPosition);
                                      },
                                      onPanEnd: (details) {
                                        context
                                            .read<DrawingStoryCubit>()
                                            .addDrawingElement();
                                        context
                                            .read<DrawingStoryCubit>()
                                            .emptyCurrentPoints();
                                      },
                                      child: Container(
                                        color: ColorManager.black,
                                        child: BlocBuilder<
                                          DrawingStoryCubit,
                                          DrawingState
                                        >(
                                          builder: (context, state) {
                                            return CustomPaint(
                                              painter: StoryPainter(
                                                drawingPaths:
                                                    state.lines +
                                                    [
                                                      if (state
                                                          .currentPoints
                                                          .isNotEmpty)
                                                        DrawingElement(
                                                          points:
                                                              state.currentPoints,
                                                          color: state.lineColor,
                                                          strokeWidth:
                                                              state.strokeWidth,
                                                        ),
                                                    ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...state.mediaFiles!.asMap().entries.map((
                                    entry,
                                  ) {
                                    return InteractiveMediaItem(
                                      media: entry.value,
                                      onScale: () => {},
                                    );
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
                                          _textKeys.putIfAbsent(
                                            e.id,
                                            () => GlobalKey(),
                                          );
                                          return BlocBuilder<
                                            TextEditingCubit,
                                            TextEditingState
                                          >(
                                            builder: (context, state) {
                                              print(
                                                state.allTextAlignment.map(
                                                  (e) => e.text,
                                                ),
                                              );
                                              return EditableTextElement(
                                                onDelete: () {
                                                  context
                                                      .read<TextEditingCubit>()
                                                      .removeTextElement(e.id);
                                                  context
                                                      .read<StoryEditorCubit>()
                                                      .removeTextElement(e.id);
                                                },
                                                onScale:
                                                    () => _changeEditingMode(
                                                      EditingMode.dragging,
                                                    ),
                                                onTap: () {
                                                  context
                                                      .read<TextEditingCubit>()
                                                      .setEditingExistingText(
                                                        true,
                                                      );
                                                  _changeEditingMode(
                                                    EditingMode.text,
                                                  );
                                                },
                                                widgetKey: _textKeys[e.id]!,
                                                textElement: e,
                                              );
                                            },
                                          );
                                        }),
                                  if (state.positionedElements.isNotEmpty)
                                    ...state.positionedElements.map((e) {
                                      _elementsKey.putIfAbsent(
                                        e.id,
                                        () => GlobalKey(),
                                      );
                                      return BlocBuilder<
                                        StoryEditorCubit,
                                        StoryEditorState
                                      >(
                                        builder: (context, state) {
                                          return PositionedElementItem(
                                            onScale: ()=>_changeEditingMode(EditingMode.dragging),
                                            onDelete: () {
                                              context
                                                  .read<StoryEditorCubit>()
                                                  .removePositionedElement(e.id);
                                            },
                                            widgetKey: _elementsKey[e.id]!,
                                            positionedElement: e,
                                          );
                                        },
                                      );
                                    }),
                                  Positioned(
                                    top: MediaQuery.of(context).padding.top + 100,
                                    right: 0,
                                    child: BlocBuilder<
                                      DrawingStoryCubit,
                                      DrawingState
                                    >(
                                      builder: (context, state) {
                                        return StrokeWidthDrawer(
                                          onChanged:
                                              context
                                                  .read<DrawingStoryCubit>()
                                                  .changeStrokeWidth,
                                          currentStrokeWidth: state.strokeWidth,
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).padding.top,
                                    left: 0,
                                    right: 0,
                                    child: EditingTopToolBar(
                                      editingMode: _currentMode,
                                      onDone: () {
                                        context
                                            .read<StoryEditorCubit>()
                                            .addTextElement(
                                          newElement:
                                          context
                                              .read<
                                              TextEditingCubit
                                          >()
                                              .state
                                              .allTextAlignment,
                                        );
                                        _changeEditingMode(
                                          EditingMode.normal,
                                        );
                                        _toggleToolbar();
                                      },
                                      onBack: () {
                                        CustomSheet.show(
                                          child: MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                value:
                                                context
                                                    .read<
                                                    StoryEditorCubit
                                                >(),
                                              ),
                                              BlocProvider.value(
                                                value:
                                                context
                                                    .read<
                                                    TextEditingCubit
                                                >(),
                                              ),
                                              BlocProvider.value(
                                                value:
                                                context
                                                    .read<
                                                    DrawingStoryCubit
                                                >(),
                                              ),
                                            ],
                                            child:
                                            ConfirmDiscardOrKeepEditingStory(),
                                          ),
                                          context: context,
                                          barrierColor: ColorManager.black
                                              .withOpacity(0.2),
                                        );
                                      },
                                      undoDrawing:
                                      context
                                          .read<DrawingStoryCubit>()
                                          .undoDrawing,
                                    ),
                                  ),                                DrawingColorPallete(),
                                ],
                              )
                              : _currentMode == EditingMode.text
                              ? BlocBuilder<StoryEditorCubit, StoryEditorState>(
                                builder: (context, state) {
                                  if (state.mediaFiles!.any(
                                    (element) =>
                                        element.offset == null ||
                                        element.offset == Offset.zero ||
                                        element.scale == null ||
                                        element.rotateAngle == null,
                                  )) {
                                    _applyCenteredGridLayout(context);
                                  }
                                  return Stack(
                                    fit: StackFit.passthrough,
                                    children: [
                                      Positioned.fill(
                                        child: GestureDetector(
                                          onTap:
                                              () => _changeEditingMode(
                                                EditingMode.normal,
                                              ),
                                          child: Container(
                                            color: ColorManager.black,
                                          ),
                                        ),
                                      ),
                                      ...state.mediaFiles!.asMap().entries.map((
                                        entry,
                                      ) {
                                        return InteractiveMediaItem(
                                          media: entry.value,
                                          onScale: () => {},
                                        );
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
                                              _textKeys.putIfAbsent(
                                                e.id,
                                                () => GlobalKey(),
                                              );
                                              return BlocBuilder<
                                                TextEditingCubit,
                                                TextEditingState
                                              >(
                                                builder: (context, state) {
                                                  print(
                                                    state.allTextAlignment.map(
                                                      (e) => e.text,
                                                    ),
                                                  );
                                                  return EditableTextElement(
                                                    onDelete: () {
                                                      context
                                                          .read<
                                                            TextEditingCubit
                                                          >()
                                                          .removeTextElement(
                                                            e.id,
                                                          );
                                                      context
                                                          .read<
                                                            StoryEditorCubit
                                                          >()
                                                          .removeTextElement(
                                                            e.id,
                                                          );
                                                    },
                                                    onScale:
                                                        () => _changeEditingMode(
                                                          EditingMode.dragging,
                                                        ),
                                                    onTap: () {
                                                      context
                                                          .read<
                                                            TextEditingCubit
                                                          >()
                                                          .setEditingExistingText(
                                                            true,
                                                          );
                                                      _changeEditingMode(
                                                        EditingMode.text,
                                                      );
                                                    },
                                                    widgetKey: _textKeys[e.id]!,
                                                    textElement: e,
                                                  );
                                                },
                                              );
                                            }),
                                      if (state.positionedElements.isNotEmpty)
                                        ...state.positionedElements.map((e) {
                                          _elementsKey.putIfAbsent(
                                            e.id,
                                            () => GlobalKey(),
                                          );
                                          return BlocBuilder<
                                            StoryEditorCubit,
                                            StoryEditorState
                                          >(
                                            builder: (context, state) {
                                              return PositionedElementItem(
                                                onScale: ()=>_changeEditingMode(EditingMode.dragging),
                                                onDelete: () {
                                                  context
                                                      .read<StoryEditorCubit>()
                                                      .removePositionedElement(
                                                        e.id,
                                                      );
                                                },
                                                widgetKey: _elementsKey[e.id]!,
                                                positionedElement: e,
                                              );
                                            },
                                          );
                                        }),
                                      TextInputOverlay(
                                        focusNode: _textFocusNode,
                                        onTextSubmitted: () {
                                          _changeEditingMode(EditingMode.normal);
                                          _toggleToolbar();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                              : _currentMode == EditingMode.normal
                              ? BlocBuilder<StoryEditorCubit, StoryEditorState>(
                                builder: (context, state) {
                                  return Stack(
                                    fit: StackFit.passthrough,
                                    children: [
                                      Positioned.fill(
                                        child: Container(
                                          color: ColorManager.black,
                                          child: BlocBuilder<
                                            DrawingStoryCubit,
                                            DrawingState
                                          >(
                                            builder: (context, state) {
                                              return CustomPaint(
                                                painter: StoryPainter(
                                                  drawingPaths:
                                                      state.lines +
                                                      [
                                                        if (state
                                                            .currentPoints
                                                            .isNotEmpty)
                                                          DrawingElement(
                                                            points:
                                                                state
                                                                    .currentPoints,
                                                            color:
                                                                state.lineColor,
                                                            strokeWidth:
                                                                state.strokeWidth,
                                                          ),
                                                      ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      ...state.mediaFiles!.asMap().entries.map((
                                        entry,
                                      ) {
                                        return InteractiveMediaItem(
                                          media: entry.value,
                                          onScale:
                                              () => _changeEditingMode(
                                                EditingMode.dragging,
                                              ),
                                        );
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
                                              _textKeys.putIfAbsent(
                                                e.id,
                                                () => GlobalKey(),
                                              );
                                              return BlocBuilder<
                                                TextEditingCubit,
                                                TextEditingState
                                              >(
                                                builder: (context, state) {
                                                  print(
                                                    state.allTextAlignment.map(
                                                      (e) => e.text,
                                                    ),
                                                  );
                                                  return EditableTextElement(
                                                    onDelete: () {
                                                      context
                                                          .read<
                                                            TextEditingCubit
                                                          >()
                                                          .removeTextElement(
                                                            e.id,
                                                          );
                                                      context
                                                          .read<
                                                            StoryEditorCubit
                                                          >()
                                                          .removeTextElement(
                                                            e.id,
                                                          );
                                                    },
                                                    onScale:
                                                        () => _changeEditingMode(
                                                          EditingMode.dragging,
                                                        ),
                                                    onTap: () {
                                                      context
                                                          .read<
                                                            TextEditingCubit
                                                          >()
                                                          .setEditingExistingText(
                                                            true,
                                                          );
                                                      _changeEditingMode(
                                                        EditingMode.text,
                                                      );
                                                    },
                                                    widgetKey: _textKeys[e.id]!,
                                                    textElement: e,
                                                  );
                                                },
                                              );
                                            }),
                                      if (state.positionedElements.isNotEmpty)
                                        ...state.positionedElements.map((e) {
                                          _elementsKey.putIfAbsent(
                                            e.id,
                                            () => GlobalKey(),
                                          );
                                          return BlocBuilder<
                                            StoryEditorCubit,
                                            StoryEditorState
                                          >(
                                            builder: (context, state) {
                                              return PositionedElementItem(
                                                onScale: ()=>_changeEditingMode(EditingMode.dragging),
                                                onDelete: () {
                                                  context
                                                      .read<StoryEditorCubit>()
                                                      .removePositionedElement(
                                                        e.id,
                                                      );
                                                },
                                                widgetKey: _elementsKey[e.id]!,
                                                positionedElement: e,
                                              );
                                            },
                                          );
                                        }),
                                      AnimatedBuilder(
                                        animation: _toolbarAnimation,
                                        builder: (context, child) {
                                          return Positioned(
                                            top:
                                                MediaQuery.of(
                                                  context,
                                                ).padding.top +
                                                100,
                                            left: 15,
                                            child: Transform.translate(
                                              offset: Offset(
                                                0,
                                                100 *
                                                    (1 - _toolbarAnimation.value),
                                              ),
                                              child: Opacity(
                                                opacity: _toolbarAnimation.value,
                                                child:
                                                    _buildSideLeftDrawingToolBar(
                                                      context,
                                                    ),
                                              ),
                                            ),
                                          );
                                        },
                                      ), // Top Toolbar
                                      Positioned(
                                        top: MediaQuery.of(context).padding.top,
                                        left: 0,
                                        right: 0,
                                        child: EditingTopToolBar(
                                          editingMode: _currentMode,
                                          onDone: () {
                                            context
                                                .read<StoryEditorCubit>()
                                                .addTextElement(
                                                  newElement:
                                                      context
                                                          .read<
                                                            TextEditingCubit
                                                          >()
                                                          .state
                                                          .allTextAlignment,
                                                );
                                            _changeEditingMode(
                                              EditingMode.normal,
                                            );
                                            _toggleToolbar();
                                          },
                                          onBack: () {
                                            CustomSheet.show(
                                              child: MultiBlocProvider(
                                                providers: [
                                                  BlocProvider.value(
                                                    value:
                                                        context
                                                            .read<
                                                              StoryEditorCubit
                                                            >(),
                                                  ),
                                                  BlocProvider.value(
                                                    value:
                                                        context
                                                            .read<
                                                              TextEditingCubit
                                                            >(),
                                                  ),
                                                  BlocProvider.value(
                                                    value:
                                                        context
                                                            .read<
                                                              DrawingStoryCubit
                                                            >(),
                                                  ),
                                                ],
                                                child:
                                                    ConfirmDiscardOrKeepEditingStory(),
                                              ),
                                              context: context,
                                              barrierColor: ColorManager.black
                                                  .withOpacity(0.2),
                                            );
                                          },
                                          undoDrawing:
                                              context
                                                  .read<DrawingStoryCubit>()
                                                  .undoDrawing,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                              : SizedBox.shrink(),
                    )
                    : SafeArea(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: () async{
                                if(   state
                                    .mediaFiles!
                                    .first
                                    .isVideoFile) {
                                  _videoController!.value.isPlaying?  await _videoController!.pause():await _videoController!.play();
                                setState(() {
                                });
                                }
                              },
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
                                                _initialRotation +
                                                details.rotation;

                                            _currentOffset +=
                                                details.focalPointDelta;
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
                                        context
                                            .read<DrawingStoryCubit>()
                                            .addNewLine(details.localPosition);
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
                                            .addDrawingElement(
                                              context
                                                  .read<DrawingStoryCubit>()
                                                  .state
                                                  .lines,
                                            );
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
                                                state
                                                        .mediaFiles!
                                                        .first
                                                        .isVideoFile
                                                    ? _buildVideoPlayer()
                                                    : _buildImageDisplay(
                                                      state
                                                          .mediaFiles!
                                                          .first
                                                          .file!,
                                                    ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: BlocBuilder<
                                      DrawingStoryCubit,
                                      DrawingState
                                    >(
                                      builder: (context, state) {
                                        return CustomPaint(
                                          painter: StoryPainter(
                                            drawingPaths:
                                                state.lines +
                                                [
                                                  if (state
                                                      .currentPoints
                                                      .isNotEmpty)
                                                    DrawingElement(
                                                      points: state.currentPoints,
                                                      color: state.lineColor,
                                                      strokeWidth:
                                                          state.strokeWidth,
                                                    ),
                                                ],
                                          ),
                                        );
                                      },
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
                                        onDelete: () {
                                          context
                                              .read<TextEditingCubit>()
                                              .removeTextElement(e.id);
                                          context
                                              .read<StoryEditorCubit>()
                                              .removeTextElement(e.id);
                                        },
                                        onScale: () => {},
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
                                  _elementsKey.putIfAbsent(
                                    e.id,
                                    () => GlobalKey(),
                                  );
                                  return BlocBuilder<
                                    StoryEditorCubit,
                                    StoryEditorState
                                  >(
                                    builder: (context, state) {
                                      return PositionedElementItem(
                                        onScale: ()=>_changeEditingMode(EditingMode.dragging),
                                        onDelete: () {
                                          context
                                              .read<StoryEditorCubit>()
                                              .removePositionedElement(e.id);
                                        },
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
                                _changeEditingMode(EditingMode.normal);
                                _toggleToolbar();
                              },
                              onBack: () {
                                if (_currentMode == EditingMode.draw) {
                                  context
                                      .read<DrawingStoryCubit>()
                                      .clearDrawing();
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
                                          value:
                                              context.read<DrawingStoryCubit>(),
                                        ),
                                      ],
                                      child: ConfirmDiscardOrKeepEditingStory(),
                                    ),
                                    context: context,
                                    barrierColor: ColorManager.black.withOpacity(
                                      0.2,
                                    ),
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
                          if(_currentMode==EditingMode.normal)
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
                              child: BlocBuilder<DrawingStoryCubit, DrawingState>(
                                builder: (context, state) {
                                  return StrokeWidthDrawer(
                                    onChanged:
                                        context
                                            .read<DrawingStoryCubit>()
                                            .changeStrokeWidth,
                                    currentStrokeWidth: state.strokeWidth,
                                  );
                                },
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
                        ],
                      ),
                    ),
          ),
        );
      },
    );
  }

  Widget _buildVideoPlayer() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        ),
        GestureDetector(
          onTap: () async{
            print('fffffffffffff');
            _videoController!.value.isPlaying?  await _videoController!.pause():await _videoController!.play();
            setState(() {
            });
          },
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              _videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 50,color: ColorManager.white,
            ),
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
            CustomSheet.show(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<StoryEditorCubit>()),
                  BlocProvider.value(value: context.read<CalculateTempCubit>()),
                  BlocProvider.value(
                    value: context.read<FeelingsActivitiesCubit>(),
                  ),
                  BlocProvider.value(value: context.read<AddLocationCubit>()),
                  BlocProvider.value(value: context.read<PostFriendsCubit>()),
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
        BlocBuilder<TextEditingCubit, TextEditingState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                _changeEditingMode(EditingMode.text);
                _toggleToolbar();
                context.read<TextEditingCubit>().setEditingExistingText(false);
              },
              child: SvgPicture.asset(AssetsManager.textAa),
            );
          },
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
}
