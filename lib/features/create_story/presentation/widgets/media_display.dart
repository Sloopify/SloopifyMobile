// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../domain/story_element_types.dart';
// import '../blocs/story_cubit/story_cubit.dart';
// import '../blocs/story_cubit/story_state.dart';
// class MediaDisplay extends StatefulWidget {
//   const MediaDisplay({Key? key}) : super(key: key);
//   @override
//   _MediaDisplayState createState() => _MediaDisplayState();
// }
// class _MediaDisplayState extends State<MediaDisplay> {
//   VideoPlayerController? _videoController;
//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<StoryCubit, StoryState>(
//       listener: (context, state) {
//         if (state.mediaType == MediaType.video && state.mediaFile != null) {
//           _videoController = VideoPlayerController.file(state.mediaFile!)
//             ..initialize().then((_) {
//               setState(() {});
//               _videoController!.play();
//               _videoController!.setLooping(true);
//             });
//         } else {
//           _videoController?.dispose();
//           _videoController = null;
//         }
//       },
//       builder: (context, state) {
//         if (state.mediaFile == null) {
//           return const Center(child: Text('No media selected.'));
//         }
//         switch (state.mediaType) {
//           case MediaType.image:
//             return Image.file(state.mediaFile!);
//           case MediaType.video:
//             return _videoController != null &&
//                 _videoController!.value.isInitialized
//                 ? AspectRatio(
//               aspectRatio: _videoController!.value.aspectRatio,
//               child: VideoPlayer(_videoController!),
//             )
//                 : const Center(child: CircularProgressIndicator());
//           case MediaType.none:
//           return const Center(child: Text('No media selected.'));
//         }
//       },
//     );
//   }
// }