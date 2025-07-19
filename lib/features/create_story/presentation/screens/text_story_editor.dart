import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/drawing_story/drawing_story_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_editor_screen.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/assets_managers.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_sheet.dart';
import '../../../create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import '../../../create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import '../../domain/entities/all_positioned_element.dart';
import '../blocs/calculate_tempreture_cubit/calculate_temp_cubit.dart';
import '../blocs/drawing_story/drawing_story_cubit.dart';
import '../blocs/story_editor_cubit/story_editor_cubit.dart';
import '../blocs/story_editor_cubit/story_editor_state.dart';
import '../blocs/text_editing_cubit/text_editing_cubit.dart';
import '../blocs/text_editing_cubit/text_editing_state.dart';
import '../widgets/background_colors_sheet.dart';
import '../widgets/confirm_discard_or_keep_editing_story.dart';
import '../widgets/drawing_color_pallete.dart';
import '../widgets/editable_text_element.dart';
import '../widgets/editing_top_tool_bar.dart';
import '../widgets/post_story_btn.dart';
import '../widgets/postitioned_element_item.dart';
import '../widgets/story_elements_sheet.dart';
import '../widgets/story_painter.dart';
import '../widgets/story_privacy_fab.dart';
import '../widgets/stroke_width_drawer.dart';
import '../widgets/text_editing_tool_bar.dart';
import '../widgets/text_input_overlay.dart';

class TextStoryEditor extends StatefulWidget {
  const TextStoryEditor({super.key});

  static const routeName = " text_story_editor";

  @override
  State<TextStoryEditor> createState() => _TextStoryEditorState();
}

class _TextStoryEditorState extends State<TextStoryEditor>
    with TickerProviderStateMixin {
  EditingMode _currentMode = EditingMode.normal;
  bool _isToolbarVisible = true;
  late AnimationController _toolbarAnimationController;
  late Animation<double> _toolbarAnimation;
  final FocusNode _textFocusNode = FocusNode();
  final Map<String, GlobalKey> _textKeys = {};
  final Map<String, GlobalKey> _elementsKey = {};

  @override
  void initState() {
    super.initState();
    _changeEditingMode(EditingMode.text);

    context.read<CalculateTempCubit>().getCurrentTemperature();
    _initializeAnimations();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<DrawingStoryCubit, DrawingState>(
              builder: (context, state) {
                return BlocBuilder<StoryEditorCubit, StoryEditorState>(
                  builder: (context, storyState) {
                    return Positioned.fill(
                      child: GestureDetector(
                        onTap: () => _changeEditingMode(EditingMode.text),
                        onPanStart:
                            _currentMode == EditingMode.draw
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
                                      .read<DrawingStoryCubit>()
                                      .emptyCurrentPoints();
                                }
                                : null,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    storyState.gradientBackground == null
                                        ? ColorManager.primaryShade4
                                            .withOpacity(0.4)
                                        : null,
                                gradient:
                                    storyState.gradientBackground != null
                                        ? LinearGradient(
                                          colors: [
                                            storyState
                                                .gradientBackground!
                                                .startColor,
                                            storyState
                                                .gradientBackground!
                                                .endColor,
                                          ],
                                        )
                                        : null,
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
                    );
                  },
                );
              },
            ),
            if (context
                    .read<TextEditingCubit>()
                    .state
                    .allTextAlignment
                    .isNotEmpty &&
                _currentMode != EditingMode.text)
              ...context.read<TextEditingCubit>().state.allTextAlignment.map((
                e,
              ) {
                _textKeys.putIfAbsent(e.id, () => GlobalKey());
                return BlocBuilder<TextEditingCubit, TextEditingState>(
                  builder: (context, state) {
                    print(state.allTextAlignment.map((e) => e.text));
                    return EditableTextElement(
                      onTap: () {
                        context.read<TextEditingCubit>().setEditingExistingText(
                          true,
                        );
                        _toggleToolbar();
                        _changeEditingMode(EditingMode.text);
                      },
                      widgetKey: _textKeys[e.id]!,
                      textElement: e,
                      onElementChanged: (updatedElement) {
                        context
                            .read<TextEditingCubit>()
                            .updateSelectedPositionedText(updatedElement);
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
              ...context.read<StoryEditorCubit>().state.positionedElements.map((
                e,
              ) {
                _elementsKey.putIfAbsent(e.id, () => GlobalKey());
                return BlocBuilder<StoryEditorCubit, StoryEditorState>(
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
                undoDrawing: context.read<DrawingStoryCubit>().undoDrawing,
              ),
            ),
            // Bottom Toolbar
            if (_currentMode == EditingMode.normal)
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
                  currentStrokeWidth:
                      context.read<DrawingStoryCubit>().state.strokeWidth,
                ),
              ),
            // Mode-specific Toolbars
            if (_currentMode == EditingMode.draw) DrawingColorPallete(),
            // Text Editing Overlay (TextField and Text Toolbar)
            if (_currentMode == EditingMode.text)
              TextInputOverlay(
                focusNode: _textFocusNode,
                fromTextStory: true,
                onTextSubmitted: () {
                  _changeEditingMode(EditingMode.normal);
                  _toggleToolbar();
                  _textFocusNode.unfocus();
                },
              ),
            if (_currentMode == EditingMode.text) TextEditingToolbar(),
          ],
        ),
      ),
    );
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
            _changeEditingMode(EditingMode.normal);
            CustomSheet.show(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<StoryEditorCubit>()),
                  BlocProvider.value(value: context.read<CalculateTempCubit>()),
                  BlocProvider.value(
                    value: context.read<FeelingsActivitiesCubit>(),
                  ),
                  BlocProvider.value(value: context.read<AddLocationCubit>()),
                  BlocProvider.value(
                    value: context.read<PostFriendsCubit>()..setFromStory(),
                  ),
                ],
                child: StoryElementsSheet(),
              ),
              context: context,
              barrierColor: ColorManager.black.withOpacity(0.2),
            ).then((value) {
              setState(() {});
            });
          },
          child: SvgPicture.asset(AssetsManager.sticker),
        ),
        Gaps.vGap4,
        BlocBuilder<StoryEditorCubit, StoryEditorState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                CustomSheet.show(
                  context: context,
                  barrierColor: ColorManager.black.withOpacity(0.2),
                  child: BlocProvider.value(
                    value: context.read<StoryEditorCubit>(),
                    child: BackgroundColorsSheet(),
                  ),
                );
              },
              child:
                  context.read<StoryEditorCubit>().state.gradientBackground ==
                          null
                      ? Icon(
                        Icons.color_lens_outlined,
                        color: ColorManager.white,
                      )
                      : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              context
                                  .read<StoryEditorCubit>()
                                  .state
                                  .gradientBackground!
                                  .startColor,
                              context
                                  .read<StoryEditorCubit>()
                                  .state
                                  .gradientBackground!
                                  .endColor,
                            ],
                          ),

                          border: Border.all(color: Colors.black26),
                        ),
                      ),
            );
          },
        ),
      ],
    );
  }
}
