import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/media_story.dart';

import '../blocs/story_editor_cubit/story_editor_cubit.dart';

class InteractiveMediaItem extends StatefulWidget {
  final MediaStory media;
  final Size size;
  final Function() onScale;

  const InteractiveMediaItem({
    Key? key,
    required this.media,
    this.size = const Size(180, 180),
    required this.onScale
  }) : super(key: key);

  @override
  State<InteractiveMediaItem> createState() => InteractiveMediaItemState();
}

class InteractiveMediaItemState extends State<InteractiveMediaItem> {
  late Offset _offset;
  late double _scale;
  late double _rotation;

  late Offset _initialOffset;
  late Offset _startFocalPoint;
  late double _initialScale;
  late double _initialRotation;

  @override
  void initState() {
    super.initState();
    _offset = widget.media.offset ?? const Offset(0, 0);
    _scale = widget.media.scale ?? 1.0;
    _rotation = widget.media.rotateAngle ?? 0.0;
  }


  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: GestureDetector(
        onScaleStart: (details) {
          _startFocalPoint = details.focalPoint;
          _initialOffset = _offset;
          _initialScale = _scale;
          _initialRotation = _rotation;

        },
        onScaleUpdate: (details) {
          setState(() {
            _scale = (_initialScale * details.scale);
            _rotation = _initialRotation + details.rotation;
            // Update the position based on finger movement
            final delta = details.focalPoint - _startFocalPoint;
            _offset = _initialOffset + delta;
          });
          final updatedMedia = widget.media.copyWith(
            offset: _offset,
            scale: _scale,
            rotateAngle: _rotation,
          );
          context.read<StoryEditorCubit>().updateSingleMedia(updatedMedia);
          widget.onScale();
        },
        onScaleEnd: (_) {
          // Persist updated media state
          final updatedMedia = widget.media.copyWith(
            offset: _offset,
            scale: _scale,
            rotateAngle: _rotation,
          );
          context.read<StoryEditorCubit>().updateSingleMedia(updatedMedia);
        },
        child: Transform.scale(
          scale: _scale,
          child: Transform.rotate(
            angle: _rotation,
            child: SizedBox(
              width: widget.size.width,
              height: widget.size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                    widget.media.isVideoFile
                        ? _buildVideoPlayer()
                        : _buildImageDisplay(widget.media.file!),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildVideoPlayer() {
  return const Placeholder(); // Replace with real video logic
}

Widget _buildImageDisplay(File file) {
  return Image.file(file, fit: BoxFit.contain);
}
