part of 'forget_password_cubit.dart';

enum OtpSendStatus { loading, init, success, error, offline }

enum VerifyOtpStatus { loading, init, success, error, offline }

enum SubmitForgetPasswordStatus { loading, init, success, error, offline }

class ForgetPasswordState extends Equatable {
  final OtpDataEntity otpDataEntity;
  final VerifyOtpEntity verifyOtpEntity;
  final String newPassword;
  final String confirmNewPassword;
  final OtpSendStatus otpSendStatus;
  final VerifyOtpStatus verifyOtpStatus;
  final SubmitForgetPasswordStatus submitForgetPasswordStatus;
  final bool hasPhoneNumberError;
  final String errorMessage;
  final int timerSeconds;
  final bool isTimerFinished;

  const ForgetPasswordState({
    required this.newPassword,
    required this.otpDataEntity,
    required this.verifyOtpEntity,
    required this.confirmNewPassword,
    required this.submitForgetPasswordStatus,
    required this.verifyOtpStatus,
    required this.otpSendStatus,
    required this.hasPhoneNumberError,
    required this.errorMessage,
    required this.timerSeconds,
    required this.isTimerFinished
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    otpDataEntity,
    verifyOtpEntity,
    newPassword,
    confirmNewPassword,
    otpSendStatus,
    verifyOtpStatus,
    submitForgetPasswordStatus,
    hasPhoneNumberError,
    errorMessage,
    timerSeconds,
    isTimerFinished
  ];

  factory ForgetPasswordState.empty() {
    return ForgetPasswordState(
      isTimerFinished: false,
      timerSeconds: 300,
      newPassword: "",
      otpDataEntity: OtpDataEntity.fromEmpty(),
      verifyOtpEntity: VerifyOtpEntity.fromEmpty(),
      confirmNewPassword: "",
      otpSendStatus: OtpSendStatus.init,
      submitForgetPasswordStatus: SubmitForgetPasswordStatus.init,
      verifyOtpStatus: VerifyOtpStatus.init,
      hasPhoneNumberError: false,
      errorMessage: ""
    );
  }

  ForgetPasswordState copyWith({
    String? mobileNumber,
    OtpSendType? otpSendType,
    String? countryCode,
    String? email,
    String? phoneNumber,
    String? fullPhoneNumber,
    String? otpCode,
    String? newPassword,
    String? confirmNewPassword,
    OtpSendStatus? otpSendStatus,
    VerifyOtpStatus? verifyOtpStatus,
    SubmitForgetPasswordStatus? submitForgetPasswordStatus,
    bool? hasPhoneNumberError,
    String? errorMessage,
    bool? isTimerFinished,
    int ? timerSeconds
  }) {
    return ForgetPasswordState(
      timerSeconds: timerSeconds??this.timerSeconds,
      isTimerFinished: isTimerFinished??this.isTimerFinished,
      errorMessage: errorMessage??this.errorMessage,
      hasPhoneNumberError: hasPhoneNumberError??this.hasPhoneNumberError,
      newPassword: newPassword ?? this.newPassword,
      otpDataEntity: otpDataEntity.copyWith(
        phoneNumbers: phoneNumber ?? otpDataEntity.phoneNumbers,
        type: otpSendType ?? otpDataEntity.type,
        countryCode: countryCode ?? otpDataEntity.countryCode,
        fullPhoneNumber: fullPhoneNumber ?? otpDataEntity.fullPhoneNumber,
        email: email ?? otpDataEntity.email,
      ),
      verifyOtpEntity: verifyOtpEntity.copyWith(
        otp: otpCode ?? verifyOtpEntity.otp,
      ),
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      submitForgetPasswordStatus:
          submitForgetPasswordStatus ?? this.submitForgetPasswordStatus,
      verifyOtpStatus: verifyOtpStatus ?? this.verifyOtpStatus,
      otpSendStatus: otpSendStatus ?? this.otpSendStatus,
    );
  }
}
