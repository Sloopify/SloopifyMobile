import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_gender_use_case.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/user_profile_entity.dart';

part 'gender_identity_state.dart';

class GenderIdentityCubit extends Cubit<CompleteGenderState> {
  final CompleteGenderUseCase completeGenderUseCase;

  GenderIdentityCubit({required this.completeGenderUseCase})
      : super(CompleteGenderState());

  void setGender(Gender gender) {
    emit(state.copyWith(
        gender: gender, completeGenderStatus: CompleteGenderStatus.init));
  }

  submitGender() async {
    emit(state.copyWith(completeGenderStatus: CompleteGenderStatus.loading));
    final res = await completeGenderUseCase.call(gender: state.gender);
    res.fold((l) {
      _mapFailureToState(emit, l, state);
    }, (r) {
      emit(state.copyWith(completeGenderStatus: CompleteGenderStatus.success));
    });
  }
  _mapFailureToState(emit, Failure f, CompleteGenderState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            completeGenderStatus: CompleteGenderStatus.offline,
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            completeGenderStatus: CompleteGenderStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

}
