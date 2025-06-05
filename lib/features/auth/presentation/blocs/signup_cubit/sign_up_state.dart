part of 'sign_up_cubit.dart';

enum SignupStatus { init, loading, done, noInternet, networkError }
enum OtpRegisterStatus { loading, init, success, error, offline }

enum VerifyRegisterOtpStatus { loading, init, success, error, offline }
class SignUpState extends Equatable {
  final SignupStatus signupStatus;
  final SignupDataEntity signupDataEntity;
  final OtpDataEntity otpDataEntity;
  final VerifyOtpEntity verifyOtpEntity;
  final String errorMessage;
  final OtpSendType otpSendType;
  final String otpCode;
  final OtpRegisterStatus otpRegisterStatus;
  final VerifyRegisterOtpStatus verifyRegisterOtpStatus;
  final bool hssPhoneNumberError;

  const SignUpState({
    required this.signupDataEntity,
    required this.signupStatus,
    required this.errorMessage,
    required this.otpSendType,
    required this.otpCode,
    required this.verifyOtpEntity,
    required this.otpRegisterStatus,
    required this.verifyRegisterOtpStatus,
    required this.otpDataEntity,
    required this.hssPhoneNumberError
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    signupStatus,
    signupDataEntity,
    errorMessage,
    otpSendType,
    otpCode,
    otpDataEntity,
    verifyOtpEntity,
    verifyRegisterOtpStatus,
    otpRegisterStatus,
    hssPhoneNumberError
  ];

  factory SignUpState.empty() {
    return SignUpState(
      hssPhoneNumberError: false,
      otpRegisterStatus: OtpRegisterStatus.init,
      verifyRegisterOtpStatus: VerifyRegisterOtpStatus.init,
      verifyOtpEntity: VerifyOtpEntity.fromEmpty(),
      otpDataEntity: OtpDataEntity.fromEmpty(),
      signupDataEntity: SignupDataEntity.empty(),
      signupStatus: SignupStatus.init,
      errorMessage: '',
      otpSendType: OtpSendType.none,
      otpCode: "",
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
    String? countryCode,
    OtpSendType? otpSendType,
    String? fullPhoneNumber,
    String? otpCode,
     OtpRegisterStatus ?otpRegisterStatus,
     VerifyRegisterOtpStatus? verifyRegisterOtpStatus,
    bool? hssPhoneNumberError
  }) {
    return SignUpState(
      hssPhoneNumberError: hssPhoneNumberError??this.hssPhoneNumberError,
      verifyRegisterOtpStatus: verifyRegisterOtpStatus??this.verifyRegisterOtpStatus,
      otpRegisterStatus: otpRegisterStatus??this.otpRegisterStatus,
      verifyOtpEntity: verifyOtpEntity.copyWith(
        otp: otpCode??this.otpCode,
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
      signupDataEntity: signupDataEntity.copyWith(
        fullPhoneNumber: fullPhoneNumber ?? signupDataEntity.fullPhoneNumber,
        mobileNumber: mobileNumber ?? signupDataEntity.mobileNumber,
        countryCode: countryCode ?? signupDataEntity.countryCode,
        firstName: firstName ?? signupDataEntity.firstName,
        lastName: lastName ?? signupDataEntity.lastName,
        email: email ?? signupDataEntity.email,
        password: password ?? signupDataEntity.password,
        confirmPassword: confirmPassword ?? signupDataEntity.confirmPassword,
        isCheckedTerms: isCheckedTerms ?? signupDataEntity.isCheckedTerms,
      ),
      signupStatus: signupStatus ?? this.signupStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      otpCode: otpCode ?? this.otpCode,
      otpSendType: otpSendType ?? this.otpSendType,
    );
  }
}
