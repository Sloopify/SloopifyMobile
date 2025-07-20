import 'package:equatable/equatable.dart';

abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object?> get props => [];
}

class RequestVideoCall extends CallEvent {}

class AcceptVideoCall extends CallEvent {}

class RejectVideoCall extends CallEvent {}

class ToggleMute extends CallEvent {}

class ToggleVideo extends CallEvent {}

class SwapView extends CallEvent {}

class PauseVideo extends CallEvent {}

class ResumeVideo extends CallEvent {}
