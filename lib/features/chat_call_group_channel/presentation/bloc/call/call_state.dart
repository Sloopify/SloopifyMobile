import 'package:equatable/equatable.dart';

enum CallType { voice, video }

class CallState extends Equatable {
  final bool isMuted;
  final bool isVideoOn;
  final bool isVideoPaused;
  final CallType callType;
  final bool isSwapped;

  const CallState({
    required this.isMuted,
    required this.isVideoOn,
    required this.isVideoPaused,
    required this.callType,
    required this.isSwapped,
  });

  factory CallState.initial() {
    return const CallState(
      isMuted: false,
      isVideoOn: true,
      isVideoPaused: false,
      callType: CallType.voice,
      isSwapped: false,
    );
  }

  CallState copyWith({
    bool? isMuted,
    bool? isVideoOn,
    bool? isVideoPaused,
    CallType? callType,
    bool? isSwapped,
  }) {
    return CallState(
      isMuted: isMuted ?? this.isMuted,
      isVideoOn: isVideoOn ?? this.isVideoOn,
      isVideoPaused: isVideoPaused ?? this.isVideoPaused,
      callType: callType ?? this.callType,
      isSwapped: isSwapped ?? this.isSwapped,
    );
  }

  @override
  List<Object?> get props => [
    isMuted,
    isVideoOn,
    isVideoPaused,
    callType,
    isSwapped,
  ];
}
