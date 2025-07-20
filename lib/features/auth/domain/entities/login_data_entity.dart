// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
enum LoginType{email,phoneNumber}
class LoginDataEntity extends Equatable {
  final String? email;
  final String password;
  final String ? phoneNumber;
  final String? countryCode;
  final bool rememberMe;
  final LoginType loginType;
  final String? fullFormatedNumber;
  const LoginDataEntity({
     this.email,
    this.phoneNumber,
    required this.password,
    required this.rememberMe,
    this.countryCode,
    required this.loginType,
     this.fullFormatedNumber
  });
  factory LoginDataEntity.empty() {
    return LoginDataEntity(
      fullFormatedNumber: "",
      email: '',
      password: '',
      phoneNumber: '',
      loginType: LoginType.email,
      rememberMe: false,
      countryCode: "+963"
    );
  }
  @override
  List<Object?> get props => [email, password,phoneNumber,rememberMe,loginType,countryCode,fullFormatedNumber];

  LoginDataEntity copyWith({
    String? email,
    String? password,
    String? phoneNumber,
    bool? rememberMe,
    LoginType? loginType,
    String? countryCode,
    String? fullFormatedPhoneNumber

  }) {
    return LoginDataEntity(
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber??this.phoneNumber,
      rememberMe: rememberMe??this.rememberMe,
      loginType: loginType??this.loginType,
      countryCode: countryCode??this.countryCode,
      fullFormatedNumber: fullFormatedPhoneNumber??fullFormatedNumber
    );
  }
}
