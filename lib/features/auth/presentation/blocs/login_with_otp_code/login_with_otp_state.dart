part of 'login_with_otp_cubit.dart';

enum OtpLoginStatus { loading, init, success, error, offline }

enum VerifyOtpLoginStatus { loading, init, success, error, offline }

class LoginWithOtpState extends Equatable {
  final OtpDataEntity otpDataEntity;
  final String errorMessage;
  final OtpLoginStatus otpLoginStatus;
  final VerifyOtpLoginStatus verifyOtpLoginStatus;
  final VerifyOtpEntity verifyOtpEntity;
  final bool hasPhoneNumberError;
  final int timerSeconds;
  final bool isTimerFinished;

  const LoginWithOtpState({
    required this.otpLoginStatus,
    required this.otpDataEntity,
    required this.errorMessage,
    required this.verifyOtpLoginStatus,
    required this.verifyOtpEntity,
    required this.hasPhoneNumberError,
    required this.isTimerFinished,
    required this.timerSeconds,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    otpDataEntity,
    errorMessage,
    otpLoginStatus,
    verifyOtpEntity,
    verifyOtpLoginStatus,
    hasPhoneNumberError,
    isTimerFinished,
    timerSeconds,
  ];

  factory LoginWithOtpState.empty() {
    return LoginWithOtpState(
      isTimerFinished: false,
      timerSeconds: 300,
      hasPhoneNumberError: false,
      verifyOtpEntity: VerifyOtpEntity.fromEmpty(),
      verifyOtpLoginStatus: VerifyOtpLoginStatus.init,
      otpLoginStatus: OtpLoginStatus.init,
      otpDataEntity: OtpDataEntity.fromEmpty(),
      errorMessage: "",
    );
  }

  LoginWithOtpState copyWith({
    OtpLoginStatus? otpLoginStatus,
    OtpSendType? type,
    String? email,
    String? countryCode,
    String? fullPhoneNUmber,
    String? otpCode,
    VerifyOtpLoginStatus? verifyOtpLoginStatus,
    String? phoneNumbers,
    String? errorMessage,
    bool? hasPhoneNumberError,

    int? timerSeconds,
    bool? isTimerFinished,
  }) {
    return LoginWithOtpState(
      timerSeconds: timerSeconds ?? this.timerSeconds,
      isTimerFinished: isTimerFinished ?? this.isTimerFinished,
      hasPhoneNumberError: hasPhoneNumberError ?? this.hasPhoneNumberError,
      verifyOtpLoginStatus: verifyOtpLoginStatus ?? this.verifyOtpLoginStatus,
      verifyOtpEntity: verifyOtpEntity.copyWith(
        otp: otpCode ?? verifyOtpEntity.otp,
      ),
      errorMessage: errorMessage ?? this.errorMessage,
      otpLoginStatus: otpLoginStatus ?? this.otpLoginStatus,
      otpDataEntity: otpDataEntity.copyWith(
        countryCode: countryCode ?? otpDataEntity.countryCode,
        fullPhoneNumber: fullPhoneNUmber ?? otpDataEntity.fullPhoneNumber,
        email: email ?? otpDataEntity.email,
        phoneNumbers: phoneNumbers ?? otpDataEntity.phoneNumbers,
        type: type ?? otpDataEntity.type,
      ),
    );
  }
}
