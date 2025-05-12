// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class OtpLoginDataEntity extends Equatable {
  final String email;
  final String otpCode;

  OtpLoginDataEntity({required this.email, required this.otpCode});

  factory OtpLoginDataEntity.empty() {
    return OtpLoginDataEntity(email: '', otpCode: '');
  }

  @override
  List<Object?> get props => [email, otpCode];

  OtpLoginDataEntity copyWith({String? email, String? otpCode}) {
    return OtpLoginDataEntity(
      email: email ?? this.email,
      otpCode: otpCode ?? this.otpCode,
    );
  }
}
