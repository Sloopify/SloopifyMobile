part of 'login_cubit.dart';

enum LoginStatus { init, loading, done, noInternet, networkError,  }
enum OtpLoginStatus { init, loading, done, noInternet, networkError,  }

class LoginState extends Equatable {
  final LoginDataEntity loginDataEntity;
  final OtpLoginDataEntity otpLoginDataEntity;
  final LoginStatus loginStatus;
  final OtpLoginStatus otpLoginStatus;
  final String errorMessage;

  LoginState({
    required this.loginStatus,
    required this.loginDataEntity,
    required this.errorMessage,
    required this.otpLoginDataEntity,
    required this.otpLoginStatus,
  });

  factory LoginState.empty() {
    return LoginState(
      otpLoginStatus: OtpLoginStatus.init,
      loginDataEntity: LoginDataEntity.empty(),
      otpLoginDataEntity: OtpLoginDataEntity.empty(),
      loginStatus: LoginStatus.init,
      errorMessage: '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    loginDataEntity,
    otpLoginDataEntity,
    loginStatus,
    errorMessage,
    otpLoginStatus
  ];

  LoginState copyWith({
    String? email,
    String? password,
    String? phoneNumber,
    LoginStatus? loginStatus,
    String? otpEmail,
    String? otpCode,
    String? errorMessage,
    bool? rememberMe,
    OtpLoginStatus? otpLoginStatus,
  }) {
    return LoginState(
      otpLoginStatus: otpLoginStatus??this.otpLoginStatus,
      otpLoginDataEntity: otpLoginDataEntity.copyWith(
        email: otpEmail ?? otpLoginDataEntity.email,
        otpCode: otpCode ?? otpLoginDataEntity.otpCode,
      ),
      loginDataEntity: loginDataEntity.copyWith(
        phoneNumber: phoneNumber ?? loginDataEntity.phoneNumber,
        email: email ?? loginDataEntity.email,
        password: password ?? loginDataEntity.password,
        rememberMe: rememberMe ?? loginDataEntity.rememberMe,
      ),
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
