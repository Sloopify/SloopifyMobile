import 'package:bloc/bloc.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_birthday_usecase.dart';

import '../../../../../core/errors/failures.dart';
import 'complete_birthday_state.dart';


class CompleteBirthdayCubit extends Cubit<CompleteBirthdayState> {
  final CompleteBirthdayUseCase completeBirthdayUseCase;
  CompleteBirthdayCubit({required this.completeBirthdayUseCase}) : super(CompleteBirthdayState());

  void setBirthDay(DateTime date){
    emit(state.copyWith(completeBirthDayStatus: CompleteBirthDayStatus.init,birthDay: date));
  }
  submitBirthDay() async {
    emit(state.copyWith(completeBirthDayStatus: CompleteBirthDayStatus.loading));
    final res = await completeBirthdayUseCase.call(bornDate: state.birthday!);
    res.fold((l) {
      _mapFailureToState(emit, l, state);
    }, (r) {
      emit(state.copyWith(completeBirthDayStatus: CompleteBirthDayStatus.success));
    });
  }

  _mapFailureToState(emit, Failure f, CompleteBirthdayState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            completeBirthDayStatus: CompleteBirthDayStatus.offline,
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            completeBirthDayStatus: CompleteBirthDayStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}
