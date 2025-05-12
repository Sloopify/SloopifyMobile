// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class LoginDataEntity extends Equatable {
  final String? email;
  final String password;
  final String ? phoneNumber;
  final bool rememberMe;
  LoginDataEntity({
     this.email,
    this.phoneNumber,
    required this.password,
    required this.rememberMe
  });
  factory LoginDataEntity.empty() {
    return LoginDataEntity(
      email: '',
      password: '',
      phoneNumber: '',
      rememberMe: false
    );
  }
  @override
  List<Object?> get props => [email, password,phoneNumber,rememberMe];

  LoginDataEntity copyWith({
    String? email,
    String? password,
    String? phoneNumber,
    bool? rememberMe,
  }) {
    return LoginDataEntity(
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber??this.phoneNumber,
      rememberMe: rememberMe??this.rememberMe
    );
  }
}
