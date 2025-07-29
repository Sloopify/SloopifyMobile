import 'package:flutter_bloc/flutter_bloc.dart';
import 'call_event.dart';
import 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc() : super(CallState.initial()) {
    on<RequestVideoCall>(_onRequestVideoCall);
    on<AcceptVideoCall>(_onAcceptVideoCall);
    on<RejectVideoCall>(_onRejectVideoCall);
    on<ToggleMute>(_onToggleMute);
    on<ToggleVideo>(_onToggleVideo);
    on<SwapView>(_onSwapView);
    on<PauseVideo>(_onPauseVideo);
    on<ResumeVideo>(_onResumeVideo);
    on<EndCall>(_onEndCall);
  }

  void _onRequestVideoCall(RequestVideoCall event, Emitter<CallState> emit) {
    emit(state.copyWith(callType: CallType.video));
  }

  void _onAcceptVideoCall(AcceptVideoCall event, Emitter<CallState> emit) {
    emit(state.copyWith(callType: CallType.video));
  }

  void _onRejectVideoCall(RejectVideoCall event, Emitter<CallState> emit) {
    emit(CallState.initial());
  }

  void _onToggleMute(ToggleMute event, Emitter<CallState> emit) {
    emit(state.copyWith(isMuted: !state.isMuted));
  }

  void _onToggleVideo(ToggleVideo event, Emitter<CallState> emit) {
    emit(state.copyWith(isVideoOn: !state.isVideoOn));
  }

  void _onSwapView(SwapView event, Emitter<CallState> emit) {
    emit(state.copyWith(isSwapped: !state.isSwapped));
  }

  void _onPauseVideo(PauseVideo event, Emitter<CallState> emit) {
    emit(state.copyWith(isVideoPaused: true));
  }

  void _onResumeVideo(ResumeVideo event, Emitter<CallState> emit) {
    emit(state.copyWith(isVideoPaused: false));
  }

  void _onEndCall(EndCall event, Emitter<CallState> emit) {
    emit(CallState.initial());
  }
}
