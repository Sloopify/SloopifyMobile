part of 'gender_identity_cubit.dart';

enum CompleteGenderStatus { loading, init, success, error, offline }

class CompleteGenderState extends Equatable {
  final Gender gender;
  final CompleteGenderStatus completeGenderStatus;
  final String errorMessage;

  const CompleteGenderState({
    this.gender = Gender.none,
    this.completeGenderStatus = CompleteGenderStatus.init,
    this.errorMessage = "",
  });

  @override
  // TODO: implement props
  List<Object?> get props => [gender, completeGenderStatus, errorMessage];

  CompleteGenderState copyWith({
    Gender? gender,
    CompleteGenderStatus? completeGenderStatus,
    String? errorMessage,
  }) {
    return CompleteGenderState(
      errorMessage: errorMessage ?? this.errorMessage,
      gender: gender ?? this.gender,
      completeGenderStatus: completeGenderStatus ?? this.completeGenderStatus,
    );
  }
}
