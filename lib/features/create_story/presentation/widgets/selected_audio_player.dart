import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/theme_manager.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String voice;
  final String audioName;
  final String audioImage;
  final int audioId;

  const AudioPlayerWidget({
    super.key,
    required this.voice,
    required this.audioName,
    required this.audioImage,
    required this.audioId,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final player = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    player.setUrl(widget.voice);
    player.play();

    initializePlayer();
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          position = Duration.zero;
        });
        player.pause();
        player.seek(position);
      }
    });
  }

  void initializePlayer() {
    player.positionStream.listen((p) => setState(() => position = p));
    player.durationStream.listen((d) => setState(() => duration = d!));
  }

  String fromDuration(Duration duration) {
    final min = duration.inMinutes.remainder(60);
    final sec = duration.inSeconds.remainder(60);
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  void handlePlaying() {
    if (player.playing) {
      player.pause();
      setState(() {});
    } else {
      initializePlayer();
      player.play();
      setState(() {});
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(AppPadding.p10),
      decoration: BoxDecoration(color: ColorManager.primaryColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.audioName,
            style: AppTheme.headline3.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorManager.white,
            ),
          ),
          Spacer(),
          _playIcon(),
          Gaps.hGap1,
          _buildSelectAudioIcon(context),
        ],
      ),
    );
  }

  Widget _playIcon() {
    return InkWell(
      onTap: () {
        handlePlaying();
      },
      child: Icon(
        player.playing ? Icons.pause : Icons.square,
        color: ColorManager.white,
      ),
    );
  }

  Widget _buildSelectAudioIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        if (context.read<StoryEditorCubit>().state.positionedElements.any(
          (e) => e is AudioElement,
        )) {
        } else {
          context.read<StoryEditorCubit>().addAudioElement(
            audioUrl: widget.voice,
            audioId: widget.audioId,
            audioImage: widget.audioImage,
            audioName: widget.audioName,
          );
        }

        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.arrow_forward, color: ColorManager.black),
      ),
    );
  }
}
