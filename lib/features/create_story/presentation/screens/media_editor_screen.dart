// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
// import 'package:sloopify_mobile/features/create_story/domain/all_positioned_element.dart';
// import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
// import 'package:video_player/video_player.dart';
// import '../blocs/story_editor_cubit/story_editor_cubit.dart';
// import '../widgets/story_painter.dart';
//
// class MediaEditingScreen extends StatefulWidget {
//   final MediaEntity media;
//
//   const MediaEditingScreen({Key? key, required this.media}) : super(key: key);
//
//   @override
//   State<MediaEditingScreen> createState() => _MediaEditingScreenState();
// }
//
// class _MediaEditingScreenState extends State<MediaEditingScreen>
//     with TickerProviderStateMixin {
//   // Controllers
//   VideoPlayerController? _videoController;
//   late AnimationController _toolbarAnimationController;
//   late Animation<double> _toolbarAnimation;
//   Color _selectedColor = Colors.red;
//   double _strokeWidth = 3.0;
//   List<Offset> _currentPoints = [];
//
//   // UI state
//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//     _initializeMedia();
//   }
//
//   void _initializeAnimations() {
//     _toolbarAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _toolbarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _toolbarAnimationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//     _toolbarAnimationController.forward();
//   }
//
//   void _initializeMedia() async {
//     if (widget.media.isVideoFile && widget.media.file != null) {
//       _videoController = VideoPlayerController.file(widget.media.file!);
//       await _videoController!.initialize();
//       _videoController!.setLooping(true);
//       _videoController!.play();
//       if (mounted) setState(() {});
//     }
//   }
//
//   @override
//   void dispose() {
//     _videoController?.dispose();
//     _toolbarAnimationController.dispose();
//     super.dispose();
//   }
//
//   void _toggleToolbar() {
//     context.read<StoryEditorCubit>().toggleToolBarVisible();
//     if (context.read<StoryEditorCubit>().state.isToolBarVisible) {
//       _toolbarAnimationController.forward();
//     } else {
//       _toolbarAnimationController.reverse();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: BlocBuilder<StoryEditorCubit, StoryEditorState>(
//         builder: (context, state) {
//           return Stack(
//             children: [
//               // Media Display
//               Positioned.fill(
//                 child: GestureDetector(
//                   onTap: _toggleToolbar,
//                   onPanStart: (details) {
//                     if (state.editingMode == EditingMode.draw) {
//                       setState(() {
//                         _currentPoints = [details.localPosition];
//                       });
//                     }
//                   },
//                   onPanUpdate: (details) {
//                     if (state.editingMode == EditingMode.draw ) {
//                       setState(() {
//                         _currentPoints.add(details.localPosition); // Add the new point
//                       });}
//                   },
//                   onPanEnd: (details) {
//                     if (state.editingMode == EditingMode.draw) {
//                       context.read<StoryEditorCubit>().addDrawingElement(
//                       List.from(_currentPoints),
//                       state.drawingColor??Colors.black,
//                        state.drawingWidth??1,
//                       );
//                     }
//                   },
//                   child: Container(
//                     color: Colors.black,
//                     child: Center(
//                       child: Transform.rotate(
//                         angle:
//                             widget.media.rotateAngle ?? 0.0 * (3.14159 / 180),
//                         child: Stack(
//                           children: [
//                             // Image or Video
//                             widget.media.isVideoFile
//                                 ? _buildVideoPlayer()
//                                 : _buildImageDisplay(),
//
//                             // Drawing Layer
//                             if (state.editingMode == EditingMode.draw)
//                               Positioned.fill(
//                                 child: CustomPaint(
//                                   painter: StoryPainter(drawingPaths: state.drawingElements +
//                                       [
//                                         if (_currentPoints.isNotEmpty) DrawingElement(
//                                           points: _currentPoints,
//                                           color: state.drawingColor!,
//                                           strokeWidth: state.drawingWidth!,
//                                         ),
//                                       ]),
//                                 ),
//                               ),
//                             // Positioned Elements (overlays)
//                             ...context
//                                 .watch<StoryEditorCubit>()
//                                 .state
//                                 .positionedElements
//                                 .map(
//                                   (element) => _buildPositionedElement(element),
//                                 ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Top Toolbar
//               AnimatedBuilder(
//                 animation: _toolbarAnimation,
//                 builder: (context, child) {
//                   return Positioned(
//                     top: MediaQuery.of(context).padding.top,
//                     left: 0,
//                     right: 0,
//                     child: Transform.translate(
//                       offset: Offset(0, -60 * (1 - _toolbarAnimation.value)),
//                       child: Opacity(
//                         opacity: _toolbarAnimation.value,
//                         child: _buildTopToolbar(context),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               // Bottom Toolbar
//               AnimatedBuilder(
//                 animation: _toolbarAnimation,
//                 builder: (context, child) {
//                   return Positioned(
//                     bottom: MediaQuery.of(context).padding.bottom,
//                     left: 0,
//                     right: 0,
//                     child: Transform.translate(
//                       offset: Offset(0, 100 * (1 - _toolbarAnimation.value)),
//                       child: Opacity(
//                         opacity: _toolbarAnimation.value,
//                         child: _buildBottomToolbar(context),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//
//               if (state.editingMode == EditingMode.draw)
//                 _buildDrawingToolbar(context),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildVideoPlayer() {
//     if (_videoController == null || !_videoController!.value.isInitialized) {
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     }
//     return AspectRatio(
//       aspectRatio: _videoController!.value.aspectRatio,
//       child: VideoPlayer(_videoController!),
//     );
//   }
//
//   Widget _buildImageDisplay() {
//     return Image.file(widget.media.file!, fit: BoxFit.contain);
//   }
//
//   Widget _buildPositionedElement(dynamic element) {
//     // This will be implemented in the next section
//     return const SizedBox.shrink();
//   }
//
//   Widget _buildTopToolbar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Back Button
//           GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.5),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.arrow_back, color: Colors.white),
//             ),
//           ),
//           // Mode Indicators
//           Row(
//             children: [
//               if (context.read<StoryEditorCubit>().state.editingMode ==
//                   EditingMode.draw)
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: const Text(
//                     "Crop",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               if (context.read<StoryEditorCubit>().state.editingMode ==
//                   EditingMode.draw)
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: const Text(
//                     "Draw",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//             ],
//           ),
//           // Action Buttons
//           Row(
//             children: [
//               // Undo Button (for drawing)
//               if (context.read<StoryEditorCubit>().state.editingMode ==
//                   EditingMode.draw)
//                 GestureDetector(
//                   onTap: context.read<StoryEditorCubit>().undoDrawing,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.5),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.undo, color: Colors.white),
//                   ),
//                 ),
//               const SizedBox(width: 8),
//               // Done Button
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.teal,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Text(
//                     "Done",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomToolbar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           // Rotate Tool
//           _buildToolButton(
//             icon: Icons.rotate_right,
//             label: "Rotate",
//             onTap: () {},
//           ),
//           // Draw Tool
//           _buildToolButton(
//             icon: Icons.brush,
//             label: "Draw",
//             isActive:
//                 context.read<StoryEditorCubit>().state.editingMode ==
//                 EditingMode.draw,
//             onTap:
//                 () =>
//                     context.read<StoryEditorCubit>().state.editingMode ==
//                             EditingMode.draw
//                         ? context.read<StoryEditorCubit>().changeEditorMode(
//                           EditingMode.normal,
//                         )
//                         : context.read<StoryEditorCubit>().changeEditorMode(
//                           EditingMode.draw,
//                         ),
//           ),
//           // Text Tool
//           _buildToolButton(
//             icon: Icons.text_fields,
//             label: "Text",
//             isActive:
//                 context.read<StoryEditorCubit>().state.editingMode ==
//                 EditingMode.text,
//             onTap:
//                 () => context.read<StoryEditorCubit>().changeEditorMode(
//                   EditingMode.text,
//                 ),
//           ),
//           // Sticker Tool
//           _buildToolButton(
//             icon: Icons.emoji_emotions,
//             label: "Stickers",
//             isActive:
//                 context.read<StoryEditorCubit>().state.editingMode ==
//                 EditingMode.sticker,
//             onTap:
//                 () => context.read<StoryEditorCubit>().changeEditorMode(
//                   EditingMode.sticker,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildToolButton({
//     required IconData icon,
//     required String label,
//     required Function() onTap,
//     bool isActive = false,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(icon, color: isActive ? Colors.black : Colors.white, size: 24),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 color: isActive ? Colors.black : Colors.white,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawingToolbar(BuildContext context) {
//     return Positioned(
//       bottom: MediaQuery.of(context).padding.bottom + 120,
//       left: 0,
//       right: 0,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Color Palette
//             Container(
//               height: 50,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children:
//                     [
//                           Colors.red,
//                           Colors.blue,
//                           Colors.green,
//                           Colors.yellow,
//                           Colors.purple,
//                           Colors.orange,
//                           Colors.pink,
//                           Colors.white,
//                           Colors.black,
//                         ]
//                         .map(
//                           (color) => GestureDetector(
//                             onTap:
//                                 () => context
//                                     .read<StoryEditorCubit>()
//                                     .changeDrawingColor(color),
//                             child: Container(
//                               width: 40,
//                               height: 40,
//                               margin: const EdgeInsets.symmetric(horizontal: 4),
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color:
//                                       _selectedColor == color
//                                           ? Colors.white
//                                           : Colors.transparent,
//                                   width: 3,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Brush Size Slider
//             Row(
//               children: [
//                 const Icon(Icons.brush, color: Colors.white, size: 16),
//                 Expanded(
//                   child: Slider(
//                     value: _strokeWidth,
//                     min: 1.0,
//                     max: 10.0,
//                     divisions: 9,
//                     activeColor: Colors.white,
//                     inactiveColor: Colors.white.withOpacity(0.3),
//                     onChanged:
//                         (value) => context
//                             .read<StoryEditorCubit>()
//                             .changeStrokeWidth(value),
//                   ),
//                 ),
//                 const Icon(Icons.brush, color: Colors.white, size: 24),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Drawing Actions
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // Clear All
//                 GestureDetector(
//                   onTap: context.read<StoryEditorCubit>().clearDrawing,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Text(
//                       "Clear",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 // Undo
//                 GestureDetector(
//                   onTap: () => context.read<StoryEditorCubit>().undoDrawing(),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.orange,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Text(
//                       "Undo",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
