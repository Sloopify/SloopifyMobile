import 'package:flutter_bloc/flutter_bloc.dart';
import 'call_event.dart';
import 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc() : super(CallState.initial()) {
    on<RequestVideoCall>((event, emit) {
      emit(state.copyWith(callType: CallType.video));
    });

    on<AcceptVideoCall>((event, emit) {
      emit(state.copyWith(callType: CallType.video));
    });

    on<RejectVideoCall>((event, emit) {
      emit(state.copyWith(callType: CallType.voice));
    });

    on<ToggleMute>((event, emit) {
      emit(state.copyWith(isMuted: !state.isMuted));
    });

    on<ToggleVideo>((event, emit) {
      emit(state.copyWith(isVideoOn: !state.isVideoOn));
    });

    on<SwapView>((event, emit) {
      emit(state.copyWith(isSwapped: !state.isSwapped));
    });

    on<PauseVideo>((event, emit) {
      emit(state.copyWith(isVideoPaused: true));
    });

    on<ResumeVideo>((event, emit) {
      emit(state.copyWith(isVideoPaused: false));
    });
  }
}
