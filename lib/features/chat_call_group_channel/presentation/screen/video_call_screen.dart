import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/call/call_bloc.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/call/call_event.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/call/call_state.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});
  static const routeName = "video_call_screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        final friendView = _buildFriendVideo(context, state);
        final userView = _buildUserVideo(context, state);

        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(child: state.isSwapped ? userView : friendView),
                Positioned(
                  bottom: 120,
                  right: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 100,
                      height: 160,
                      child: state.isSwapped ? friendView : userView,
                    ),
                  ),
                ),
                _buildControls(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFriendVideo(BuildContext context, CallState state) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/friendlist/vd1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child:
          state.isVideoPaused
              ? Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.black54,
                  child: const Text(
                    "Your friend paused the video",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  Widget _buildUserVideo(BuildContext context, CallState state) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Icon(
          state.isVideoOn ? Icons.videocam : Icons.videocam_off,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context, CallState state) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _iconButton(Icons.call_end, Colors.red, () {
              Navigator.pop(context); // Or trigger end call event
            }),
            _iconButton(
              state.isMuted ? Icons.mic_off : Icons.mic,
              Colors.white,
              () => context.read<CallBloc>().add(ToggleMute()),
            ),
            _iconButton(
              state.isVideoOn ? Icons.videocam : Icons.videocam_off,
              Colors.white,
              () => context.read<CallBloc>().add(ToggleVideo()),
            ),
            _iconButton(
              Icons.swap_horiz,
              Colors.white,
              () => context.read<CallBloc>().add(SwapView()),
            ),
            _iconButton(
              state.isVideoPaused ? Icons.play_arrow : Icons.pause,
              Colors.white,
              () {
                if (state.isVideoPaused) {
                  context.read<CallBloc>().add(ResumeVideo());
                } else {
                  context.read<CallBloc>().add(PauseVideo());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, Color color, VoidCallback onPressed) {
    return CircleAvatar(
      backgroundColor: Colors.grey[800],
      child: IconButton(icon: Icon(icon, color: color), onPressed: onPressed),
    );
  }
}
