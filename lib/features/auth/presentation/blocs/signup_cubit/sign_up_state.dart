part of 'sign_up_cubit.dart';

@immutable
enum SignupStatus { init, loading, done, noInternet, networkError }

class SignUpState extends Equatable {
  final SignupStatus signupStatus;
  final SignupDataEntity signupDataEntity;
  final String errorMessage;

  const SignUpState({
    required this.signupDataEntity,
    required this.signupStatus,
    required this.errorMessage,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [signupStatus, signupDataEntity, errorMessage];

  factory SignUpState.empty() {
    return SignUpState(
      signupDataEntity: SignupDataEntity.empty(),
      signupStatus: SignupStatus.init,
      errorMessage: '',
    );
  }

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isCheckedTerms,
    SignupStatus? signupStatus,
    String? errorMessage,
    String? mobileNumber,
    String ? countryCode,
  }) {
    return SignUpState(
      signupDataEntity: signupDataEntity.copyWith(
        mobileNumber: mobileNumber??signupDataEntity.mobileNumber,
        countryCode: countryCode??signupDataEntity.countryCode,
        firstName: firstName ?? signupDataEntity.firstName,
        lastName: lastName ?? signupDataEntity.lastName,
        email: email ?? signupDataEntity.email,
        password: password ?? signupDataEntity.password,
        confirmPassword: confirmPassword ?? signupDataEntity.confirmPassword,
        isCheckedTerms: isCheckedTerms ?? signupDataEntity.isCheckedTerms,
      ),
      signupStatus: signupStatus ?? this.signupStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
