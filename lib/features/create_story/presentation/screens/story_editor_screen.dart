import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/editing_top_tool_bar.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/story_painter.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/stroke_width_drawer.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

import '../../domain/text_properties_story.dart';
import '../blocs/story_editor_cubit/story_editor_cubit.dart';
import '../widgets/editable_text_element.dart';
import '../widgets/text_input_overlay.dart';

enum EditingMode { normal, crop, draw, text, sticker }

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

  // Drawing state
  List<Offset> _currentPoints = [];
  Color _selectedColor = Colors.red;
  double _strokeWidth = 5.0;
  List<DrawingElement> _drawingLines = [];

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

  // Text Editing State (now using String? and bool? as per TextPropertiesForStory)
  Color? _currentTextColorString = Colors.white; // Default to 'white' string
  String? _currentFontTypeString = 'Roboto'; // Default to 'Roboto' string
  bool? _currentTextBold = false;
  bool? _currentTextItalic = false;
  String currentText="";
  bool? _currentTextUnderline = false;
  String? _currentTextAlignmentString = 'center'; // Default to 'center' string
  // The single text element currently being edited/manipulated
  PositionedTextElement? _activeTextElement;
  final GlobalKey _activeTextElementKey = GlobalKey();
  // List of finalized text elements (not currently being edited)
  List<PositionedTextElement> _textElements = [];
  final Map<PositionedTextElement, GlobalKey> _finalizedTextElementKeys = {};
  // Initial transformation values for the active text element during a gesture
  Offset _initialActiveTextElementOffset = Offset.zero;
  double _initialActiveTextElementScale = 1.0;
  double _initialActiveTextElementRotation = 0.0;
  final Uuid _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
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
  // Text Editing Callbacks
  void _onTextPropertiesUpdated(
      String text,
      Color? color,
      String? fontType,
      bool? bold,
      bool? italic,
      bool? underline,
      double? fontSize,
      String? alignment,
      ) {
    setState(() {
      currentText=text;
      final textProperties = TextPropertiesForStory(
        fontSize: fontSize,
        color: color,
        fontType: fontType,
        bold: bold,
        italic: italic,
        underline: underline,
        alignment: alignment,
      );

      if (_activeTextElement == null) {
        // This case should ideally not happen if we always create _activeTextElement
        // when entering text mode, but as a fallback:
        _activeTextElement = PositionedTextElement(
          id: _uuid.v4(),
          textPropertiesForStory: textProperties,
          offset: Offset.zero, // Will be updated by TextInputOverlay
          size: Size.zero,
          rotation: 0.0,
          positionedElementStoryTheme: null, text: '',
        );
      } else {
        _activeTextElement = _activeTextElement!.copyWith(
          textProperty: textProperties,
        );
      }
    });
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

  void _undoDrawing() {
    if (_drawingLines.isNotEmpty) {
      setState(() {
        _drawingLines.removeLast();
      });
    }
  }

  void _clearDrawing() {
    setState(() {
      _drawingLines.clear();
      _currentPoints = [];
    });
  }

  void _changeDrawingColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _changeStrokeWidth(double width) {
    setState(() {
      _strokeWidth = width;
    });
  }
  // Text Editing Callbacks (now using String? and bool?)
  void _onTextSubmitted(String text) {
    if (text.isNotEmpty) {
      setState(() {
        final textProperties = TextPropertiesForStory(
          fontSize: _activeTextElement?.textPropertiesForStory.fontSize ?? 24.0,
          color: _currentTextColorString,
          fontType: _currentFontTypeString,
          bold: _currentTextBold,
          italic: _currentTextItalic,
          underline: _currentTextUnderline,
          alignment: _currentTextAlignmentString,
        );
        _textElements.add(PositionedTextElement(
          id: _uuid.v4(),
          textPropertiesForStory: textProperties,
          offset: Offset.zero, // Placeholder for finalPosition
          size: Size.zero,     // Placeholder for final size
          rotation: 0.0, // Initial rotation for text element
          positionedElementStoryTheme: null, text: text, // As per your requirement
        ));
        _changeEditingMode(EditingMode.normal);
      });
    } else {
    }
  }



  void _updateActiveTextElementMeasurement(
      PositionedTextElement element, Offset finalPosition, Size size) {
    setState(() {
      _activeTextElement = element.copyWith(
        offset: finalPosition,
        size: size,
      );
    });
  }

  void _changeCurrentTextColorString(Color? color) {
    setState(() {
      _currentTextColorString = color;
    });
  }

  void _changeCurrentFontTypeString(String? fontType) {
    setState(() {
      _currentFontTypeString = fontType;
    });
  }

  void _toggleCurrentTextBold(bool? bold) {
    setState(() {
      _currentTextBold = bold;
    });
  }

  void _toggleCurrentTextItalic(bool? italic) {
    setState(() {
      _currentTextItalic = italic;
    });
  }

  void _toggleCurrentTextUnderline(bool? underline) {
    setState(() {
      _currentTextUnderline = underline;
    });
  }

  void _changeCurrentTextAlignmentString(String? alignment) {
    setState(() {
      _currentTextAlignmentString = alignment;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<StoryEditorCubit, StoryEditorState>(
        builder: (context, state) {
          return Stack(
            children: [
              // Media Display
              Positioned.fill(
                child: GestureDetector(
                  onScaleUpdate:_currentMode!=EditingMode.draw && _currentMode!=EditingMode.text? (details) {
                    if (_currentMode != EditingMode.draw) {
                      setState(() {
                        // Update scale
                        _currentScale = _initialScale * details.scale;

                        // Update rotation
                        _currentRotation = _initialRotation + details.rotation;

                        _currentOffset += details.focalPointDelta;
                      });
                    }
                  }:null,
                  onScaleStart: _currentMode!=EditingMode.draw && _currentMode!=EditingMode.text?(details) {
                    if (_currentMode != EditingMode.draw) {
                      _initialScale = _currentScale;
                      _initialRotation = _currentRotation;
                      _initialOffset = _currentOffset;
                    }
                  }:null,
                  onTap: () {},
                  onPanStart:_currentMode==EditingMode.draw? (details) {
                    setState(() {
                      _currentPoints = [details.localPosition];
                    });
                  }:null,
                  onPanUpdate: _currentMode==EditingMode.draw?(details) {
                    setState(() {
                      _currentPoints.add(
                        details.localPosition,
                      ); // Add the new point
                    });
                  }:null,
                  onPanEnd: _currentMode==EditingMode.draw?(details) {
                    _drawingLines.add(
                      DrawingElement(
                        color: _selectedColor,
                        points: List.from(_currentPoints),
                        strokeWidth: _strokeWidth,
                      ),
                    );
                    context.read<StoryEditorCubit>().addDrawingElement(
                      List.from(_currentPoints),
                      _selectedColor,
                      _strokeWidth,
                    );
                    setState(() {
                      _currentPoints = []; // Clear for the next drawing
                    });
                  }:null,
                  child: Container(
                    color: Colors.black,
                    child: Transform.translate(
                      offset: _currentOffset, // Apply translation first
                      child: Transform.rotate(
                        angle: _mediaInitialRotationRadians + _currentRotation, // Combine initial and gesture rotation
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
                                          _drawingLines +
                                          [
                                            if (_currentPoints.isNotEmpty)
                                              DrawingElement(
                                                points: _currentPoints,
                                                color: _selectedColor,
                                                strokeWidth: _strokeWidth,
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
                                    (element) => _buildPositionedElement(element),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_textElements.isNotEmpty)
                EditableTextElement(
                  textElement: _textElements.first,
                  onElementChanged: (updatedElement) {
                    setState(() {
                      _activeTextElement = updatedElement;
                    });
                  },
                ),
              // Top Toolbar
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: EditingTopToolBar(
                  editingMode: _currentMode,
                  onDone: () {},
                  onBack: () {
                    if (_currentMode == EditingMode.draw) {
                      _clearDrawing();
                      _changeEditingMode(EditingMode.normal);
                      _toggleToolbar();
                    }
                  },
                  undoDrawing: _undoDrawing,
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
                        child: _buildSideLeftDrawingToolBar(),
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
                    onChanged: _changeStrokeWidth,
                    currentStrokeWidth: _strokeWidth,
                  ),
                ),
              // Mode-specific Toolbars
              if (_currentMode == EditingMode.draw) _buildColorPallete(),
              // Text Editing Overlay (TextField and Text Toolbar)
              if (_currentMode == EditingMode.text)
                TextInputOverlay(
                  initialText: currentText,
                  initialColor: _currentTextColorString,
                  initialFontTypeString: _currentFontTypeString,
                  initialBold: _currentTextBold,
                  initialItalic: _currentTextItalic,
                  initialUnderline: _currentTextUnderline,
                  initialAlignmentString: _currentTextAlignmentString,
                  onTextSubmitted: (text) => _onTextSubmitted(text),
                  onColorChanged: _changeCurrentTextColorString,
                  onFontTypeStringChanged: _changeCurrentFontTypeString,
                  onBoldChanged: _toggleCurrentTextBold,
                  onItalicChanged: _toggleCurrentTextItalic,
                  onUnderlineChanged: _toggleCurrentTextUnderline,
                  onAlignmentStringChanged: _changeCurrentTextAlignmentString,
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
    return AspectRatio(
      aspectRatio: _videoController!.value.aspectRatio,
      child: VideoPlayer(_videoController!),
    );
  }

  Widget _buildImageDisplay() {
    return Image.file(widget.media.file!, fit: BoxFit.contain);
  }

  Widget _buildPositionedElement(dynamic element) {
    // This will be implemented in the next section
    return const SizedBox.shrink();
  }


  Widget _buildSideLeftDrawingToolBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            _changeEditingMode(EditingMode.draw);
            _toggleToolbar();
          },
          icon: Icon(Icons.brush,color: ColorManager.white,size: 24,),
        ),
        Gaps.vGap2,
        InkWell(
          onTap: () {
            _toggleToolbar();
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

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? Colors.black : Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPallete() {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 50,
      left: 50,
      right: 0,
      child: Center(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                [
                      Colors.red,
                      Colors.blue,
                      Colors.green,
                      Colors.yellow,
                      Colors.purple,
                      Colors.orange,
                      Colors.pink,
                      Colors.white,
                      Colors.black,
                    ]
                    .map(
                      (color) => GestureDetector(
                        onTap: () => _changeDrawingColor(color),
                        child: Container(
                          width: 25,
                          height: 25,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  _selectedColor == color
                                      ? Colors.white
                                      : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
  // Helper for displaying and manipulating text elements
  Widget _buildPositionedTextElement(
      PositionedTextElement element,
      GlobalKey key,
      Function(PositionedTextElement, Offset, Size) onMeasurementComplete,
      {bool isEditable = false} // New parameter
      ) {
    // Initial measurement callback (only for editable elements)
    if (isEditable) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null && element.size == Size.zero) {
          final size = renderBox.size;
          final position = renderBox.localToGlobal(Offset.zero);
          onMeasurementComplete(element, position, size);
        }
      });
    }

    final textProps = element.textPropertiesForStory;


    // Helper to convert string alignment to TextAlign
    TextAlign _stringToTextAlign(String? alignString) {
      switch (alignString?.toLowerCase()) {
        case 'left': return TextAlign.left;
        case 'center': return TextAlign.center;
        case 'right': return TextAlign.right;
        default: return TextAlign.center;
      }
    }

    // Helper to get font weight
    FontWeight _getFontWeight(bool? bold) {
      return (bold ?? false) ? FontWeight.bold : FontWeight.normal;
    }

    // Helper to get font style
    FontStyle _getFontStyle(bool? italic) {
      return (italic ?? false) ? FontStyle.italic : FontStyle.normal;
    }

    // Helper to get text decoration
    TextDecoration _getTextDecoration(bool? underline) {
      return (underline ?? false) ? TextDecoration.underline : TextDecoration.none;
    }

    // Gesture handling for the text element
    return Positioned(
      left: element.offset?.dx,
      top: element.offset?.dy,
      child: GestureDetector(
        onTap: isEditable ? () {
          // When tapping an active text element, re-enter text editing mode
          setState(() {
            _activeTextElement = element; // Set this as the active element
            _currentTextColorString = element.textPropertiesForStory.color;
            _currentFontTypeString = element.textPropertiesForStory.fontType;
            _currentTextBold = element.textPropertiesForStory.bold;
            _currentTextItalic = element.textPropertiesForStory.italic;
            _currentTextUnderline = element.textPropertiesForStory.underline;
            _currentTextAlignmentString = element.textPropertiesForStory.alignment;
            _changeEditingMode(EditingMode.text);
          });
        } : null, // Only active elements are tappable for re-editing
        onPanStart: isEditable ? (details) {
          setState(() {
            _initialActiveTextElementOffset = element.offset!;
          });
        } : null,
        onPanUpdate: isEditable ? (details) {
          setState(() {
            _activeTextElement = element.copyWith(
              offset: _initialActiveTextElementOffset + details.delta,
            );
          });
        } : null,
        onPanEnd: isEditable ? (details) {
          // No-op, state is already updated
        } : null,
        onScaleStart: isEditable ? (details) {
          setState(() {
            _initialActiveTextElementScale = element.textPropertiesForStory.fontSize ?? 24.0; // Store initial font size
            _initialActiveTextElementRotation = element.rotation!;
            _initialActiveTextElementOffset = element.offset!; // Store initial offset for pivot calculation
          });
        } : null,
        onScaleUpdate: isEditable ? (details) {
          setState(() {
            // Calculate new font size based on initial font size and gesture scale
            final newFontSize = _initialActiveTextElementScale * details.scale;

            // Update rotation
            final newRotation = _initialActiveTextElementRotation + details.rotation;

            // Calculate new offset to keep the element centered during scale/rotate
            // This is a more robust approach for focal point scaling/rotation
            final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
            final elementCenter = renderBox.size.center(element.offset!);

            final newOffset = elementCenter - (details.focalPoint - details.focalPointDelta);

            _activeTextElement = element.copyWith(
              textProperty: element.textPropertiesForStory.copyWith(fontSize: newFontSize), // Update font size in text properties
              rotation: newRotation,
              offset: newOffset, // Update element offset
            );
          });
        } : null,
        onScaleEnd: isEditable ? (details) {
          // No-op, state is already updated
        } : null,
        child: Transform.translate(
          offset: Offset(element.size!.width / 2, element.size!.height / 2), // Move origin to center for rotation/scaling
          child: Transform.rotate(
            angle: element.rotation!,
            child: Transform.scale(
              scale: (element.textPropertiesForStory.fontSize ?? 24.0) / 24.0, // Apply scale based on current font size relative to a base (e.g., 24.0)
              child: Transform.translate(
                offset: Offset(-element.size!.width / 2, -element.size!.height / 2), // Move back
                child: Container(
                  decoration: _getTextBackgroundDecoration(textProps.color, textProps.alignment),
                  padding: _getTextBackgroundPadding(textProps.alignment),
                  child: Text(
                   currentText,
                    key: key,
                    textAlign: _stringToTextAlign(textProps.alignment),
                    style: TextStyle(
                      color: textProps.color,
                      fontSize: textProps.fontSize ?? 24.0, // Use the actual font size from properties
                      fontWeight: _getFontWeight(textProps.bold),
                      fontStyle: _getFontStyle(textProps.italic),
                      decoration: _getTextDecoration(textProps.underline),
                      fontFamily: textProps.fontType,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Updated background decoration helper
  BoxDecoration? _getTextBackgroundDecoration(Color? colorString, String? alignmentString) {
    // This logic needs to be adapted based on how you represent background styles
    // in TextPropertiesForStory. It currently only has color and alignment.
    // If 'alignment' is used to imply a background style (e.g., 'filled'),
    // you'd need a mapping. For now, I'll assume a simple filled background
    // if a color is present and it's not 'none' or 'null'.
    if (colorString != null && colorString != 'null' && colorString != 'none') {
      return BoxDecoration(
        color: colorString.withOpacity(0.5), // Example: semi-transparent background
        borderRadius: BorderRadius.circular(8),
      );
    }
    return null;
  }

  // Helper for background padding
  EdgeInsetsGeometry _getTextBackgroundPadding(String? alignmentString) {
    // If you have different background styles, you might need different padding
    // For now, a generic padding if a background is implied.
    if (alignmentString != null && alignmentString != 'none') { // Assuming 'none' means no background
      return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
    }
    return EdgeInsets.zero;
  }








}

