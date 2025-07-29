import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/call/call_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/call/call_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/call/call_state.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});
  static const routeName = "video_call_screen";

  static Widget withBloc() {
    return BlocProvider(
      create: (context) => CallBloc()..add(InitCall()), // initialize if needed
      child: const VideoCallScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
      builder: (context, state) {
        final isSwapped = state.isSwapped ?? false;
        final isMuted = state.isMuted ?? false;
        final isVideoOn = state.isVideoOn ?? true;
        final isVideoPaused = state.isVideoPaused ?? false;

        final friendView = _buildFriendVideo(isVideoPaused);
        final userView = _buildUserVideo(isVideoOn);

        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(child: isSwapped ? userView : friendView),
                Positioned(
                  bottom: 120,
                  right: 16,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 100,
                      height: 160,
                      child: isSwapped ? friendView : userView,
                    ),
                  ),
                ),
                _buildControls(context, isMuted, isVideoOn, isVideoPaused),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFriendVideo(bool isVideoPaused) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/friendlist/vd1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child:
          isVideoPaused
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

  Widget _buildUserVideo(bool isVideoOn) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Icon(
          isVideoOn ? Icons.videocam : Icons.videocam_off,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildControls(
    BuildContext context,
    bool isMuted,
    bool isVideoOn,
    bool isVideoPaused,
  ) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _iconButton(Icons.call_end, Colors.red, () {
              Navigator.pop(context); // Or trigger end call event
            }),
            _iconButton(
              isMuted ? Icons.mic_off : Icons.mic,
              Colors.white,
              () => context.read<CallBloc>().add(ToggleMute()),
            ),
            _iconButton(
              isVideoOn ? Icons.videocam : Icons.videocam_off,
              Colors.white,
              () => context.read<CallBloc>().add(ToggleVideo()),
            ),
            _iconButton(
              Icons.swap_horiz,
              Colors.white,
              () => context.read<CallBloc>().add(SwapView()),
            ),
            _iconButton(
              isVideoPaused ? Icons.play_arrow : Icons.pause,
              Colors.white,
              () {
                if (isVideoPaused) {
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
