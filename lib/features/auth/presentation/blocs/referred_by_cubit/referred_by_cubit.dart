import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_referred_by_use_case.dart';

import '../../../../../core/errors/failures.dart';

part 'referred_by_state.dart';

class ReferredByCubit extends Cubit<ReferredBtyState> {
  final CompleteReferredByUseCase completeReferredByUseCase;
  ReferredByCubit({required this.completeReferredByUseCase}) : super(ReferredBtyState());
  void setReferredCode(String code) {
    emit(state.copyWith(
        referredBy: code, referredByStatus: SubmitReferredByStatus.init));
  }

  submitReferredBy() async {
    emit(state.copyWith(referredByStatus: SubmitReferredByStatus.loading));
    final res = await completeReferredByUseCase.call(referredBy: state.referredByCode);
    res.fold((l) {
      _mapFailureToState(emit, l, state);
    }, (r) {
      emit(state.copyWith(referredByStatus: SubmitReferredByStatus.success));
    });
  }
  _mapFailureToState(emit, Failure f, ReferredBtyState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            referredByStatus: SubmitReferredByStatus.offline,
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            referredByStatus: SubmitReferredByStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

}
