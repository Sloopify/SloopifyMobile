part of 'login_cubit.dart';

enum LoginStatus { init, loading, done, noInternet, networkError,  }

class LoginState extends Equatable {
  final LoginDataEntity loginDataEntity;
  final bool phoneNumberHasError;
  final LoginStatus loginStatus;
  final String errorMessage;

  LoginState({
    required this.loginStatus,
    required this.loginDataEntity,
    required this.errorMessage,
    required this.phoneNumberHasError,
  });

  factory LoginState.empty() {
    return LoginState(
      phoneNumberHasError: false,
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
    phoneNumberHasError

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
    String ? fullPhoneNumber,
    bool? phoneNumberHasError
  }) {
    return LoginState(
      phoneNumberHasError: phoneNumberHasError??this.phoneNumberHasError,
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
