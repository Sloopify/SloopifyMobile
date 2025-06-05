

import 'package:equatable/equatable.dart';

enum CompleteBirthDayStatus { loading, init, success, error, offline }

class CompleteBirthdayState extends Equatable {
  final DateTime? birthday;
  final CompleteBirthDayStatus completeBirthDayStatus;
  final String errorMessage;

  const CompleteBirthdayState({
    this.birthday,
    this.completeBirthDayStatus = CompleteBirthDayStatus.init,
    this.errorMessage = "",
  });

  @override
  // TODO: implement props
  List<Object?> get props => [birthday, completeBirthDayStatus, errorMessage];

CompleteBirthdayState copyWith({
    DateTime? birthDay,
  CompleteBirthDayStatus? completeBirthDayStatus,
    String? errorMessage,
  }) {
    return CompleteBirthdayState(
      errorMessage: errorMessage ?? this.errorMessage,
      birthday: birthDay ?? birthday,
      completeBirthDayStatus: completeBirthDayStatus ?? this.completeBirthDayStatus,
    );
  }
}
