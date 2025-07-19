part of 'verify_account_by_signup_cubit.dart';

enum OtpRegisterStatus { loading, init, success, error, offline }

enum VerifyRegisterOtpStatus { loading, init, success, error, offline }

class VerifyAccountBySignupState extends Equatable {
  final OtpDataEntity otpDataEntity;
  final VerifyOtpEntity verifyOtpEntity;
  final String errorMessage;
  final OtpSendType otpSendType;
  final String otpCode;
  final OtpRegisterStatus otpRegisterStatus;
  final VerifyRegisterOtpStatus verifyRegisterOtpStatus;
  final bool hssPhoneNumberError;
  final int timerSeconds;
  final bool isTimerFinished;

  const VerifyAccountBySignupState({
    required this.errorMessage,
    required this.otpDataEntity,
    required this.otpSendType,
    required this.verifyOtpEntity,
    required this.otpCode,
    required this.hssPhoneNumberError,
    required this.verifyRegisterOtpStatus,
    required this.otpRegisterStatus,
    required this.isTimerFinished,
    required this.timerSeconds,
  });

  factory VerifyAccountBySignupState.empty() {
    return VerifyAccountBySignupState(
      isTimerFinished: false,
      timerSeconds: 300,
      errorMessage: "",
      otpDataEntity: OtpDataEntity.fromEmpty(),
      otpSendType: OtpSendType.email,
      verifyOtpEntity: VerifyOtpEntity.fromEmpty(),
      otpCode: "",
      hssPhoneNumberError: false,
      verifyRegisterOtpStatus: VerifyRegisterOtpStatus.init,
      otpRegisterStatus: OtpRegisterStatus.init,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    errorMessage,
    otpDataEntity,
    otpSendType,
    otpCode,
    hssPhoneNumberError,
    verifyRegisterOtpStatus,
    otpRegisterStatus,
    isTimerFinished,
    timerSeconds
  ];

  VerifyAccountBySignupState copyWith({
    String? mobileNumber,
    String? countryCode,
    OtpSendType? otpSendType,
    String? fullPhoneNumber,
    String? email,
    String? otpCode,
    String? errorMessage,
    OtpRegisterStatus? otpRegisterStatus,
    VerifyRegisterOtpStatus? verifyRegisterOtpStatus,
    bool? hssPhoneNumberError,
    int ? timerSeconds,
    bool ? isTimerFinished,
  }) {
    return VerifyAccountBySignupState(
      timerSeconds: timerSeconds??this.timerSeconds,
      isTimerFinished: isTimerFinished??this.isTimerFinished,
      errorMessage: errorMessage ?? this.errorMessage,
      verifyOtpEntity: verifyOtpEntity.copyWith(
        otp: otpCode ?? this.otpCode,
        email: email ?? verifyOtpEntity.email,
        otpSendType: otpSendType ?? verifyOtpEntity.otpSendType,
        phone: fullPhoneNumber ?? verifyOtpEntity.phone,
      ),
      otpDataEntity: otpDataEntity.copyWith(
        email: email ?? otpDataEntity.email,
        fullPhoneNumber: fullPhoneNumber ?? otpDataEntity.fullPhoneNumber,
        countryCode: countryCode ?? otpDataEntity.countryCode,
        type: otpSendType ?? otpDataEntity.type,
        phoneNumbers: mobileNumber ?? otpDataEntity.phoneNumbers,
      ),
      otpSendType: otpSendType ?? this.otpSendType,
      otpCode: otpCode ?? this.otpCode,
      hssPhoneNumberError: hssPhoneNumberError ?? this.hssPhoneNumberError,
      verifyRegisterOtpStatus:
          verifyRegisterOtpStatus ?? this.verifyRegisterOtpStatus,
      otpRegisterStatus: otpRegisterStatus ?? this.otpRegisterStatus,
    );
  }
}
