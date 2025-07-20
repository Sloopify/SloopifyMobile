import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/theme_manager.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String voice;
  final String audioName;

  const AudioPlayerWidget({
    super.key,
    required this.voice,
    required this.audioName,
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
      decoration: BoxDecoration(color: ColorManager.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.audioName,
            style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
          ),
          Spacer(),
          _playIcon(),
        ],
      ),
    );
  }

  Widget _playIcon() {
    return InkWell(
      onTap: () {
        handlePlaying();
      },
      child: Container(
        alignment: Alignment.center,
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.circle,
        ),
        child: Icon(
          player.playing ? Icons.pause : Icons.square,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
