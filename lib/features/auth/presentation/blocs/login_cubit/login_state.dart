part of 'login_cubit.dart';

enum LoginStatus { init, loading, done, noInternet, networkError,  }

class LoginState extends Equatable {
  final LoginDataEntity loginDataEntity;
  final LoginStatus loginStatus;
  final String errorMessage;

  LoginState({
    required this.loginStatus,
    required this.loginDataEntity,
    required this.errorMessage,
  });

  factory LoginState.empty() {
    return LoginState(
      loginDataEntity: LoginDataEntity.empty(),
      loginStatus: LoginStatus.init,
      errorMessage: '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    loginDataEntity,
    loginStatus,
    errorMessage,

  ];

  LoginState copyWith({
    String? email,
    String? password,
    String? phoneNumber,
    LoginStatus? loginStatus,
    String? errorMessage,
    bool? rememberMe,
    String? countryCode,
    LoginType? loginType,
    String ? fullPhoneNumber
  }) {
    return LoginState(
      loginDataEntity: loginDataEntity.copyWith(
        loginType: loginType??loginDataEntity.loginType,
        countryCode: countryCode??loginDataEntity.countryCode,
        fullFormatedPhoneNumber: fullPhoneNumber??loginDataEntity.fullFormatedNumber,
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
