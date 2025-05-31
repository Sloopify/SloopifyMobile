part of 'login_with_otp_cubit.dart';

enum OtpLoginStatus { loading, init, success, error, offline }

enum VerifyOtpLoginStatus { loading, init, success, error, offline }

class LoginWithOtpState extends Equatable {
  final OtpDataEntity otpDataEntity;
  final String errorMessage;
  final OtpLoginStatus otpLoginStatus;
  final VerifyOtpLoginStatus verifyOtpLoginStatus;
  final VerifyOtpEntity verifyOtpEntity;

  const LoginWithOtpState({
    required this.otpLoginStatus,
    required this.otpDataEntity,
    required this.errorMessage,
    required this.verifyOtpLoginStatus,
    required this.verifyOtpEntity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    otpDataEntity,
    errorMessage,
    otpLoginStatus,
    verifyOtpEntity,
    verifyOtpLoginStatus,
  ];

  factory LoginWithOtpState.empty() {
    return LoginWithOtpState(
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
  }) {
    return LoginWithOtpState(
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
