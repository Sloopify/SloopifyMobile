import 'package:equatable/equatable.dart';

import 'otp_data_entity.dart';

class VerifyOtpEntity extends Equatable {
  final String otp;
  final OtpSendType otpSendType;
  final String? email;
  final String? phone;

  VerifyOtpEntity({
    required this.otp,
    required this.otpSendType,
    this.email,
    this.phone,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [otp, otpSendType, email, phone];

  factory VerifyOtpEntity.fromEmpty() {
    return VerifyOtpEntity(
      otp: "",
      otpSendType:  OtpSendType.email,
      email: null,
      phone: null,
    );
  }

  VerifyOtpEntity copyWith({
    String? otp,
    OtpSendType? otpSendType,
    String? email,
    String? phone,
  }) {
    return VerifyOtpEntity(
      otp: otp ?? this.otp,
      otpSendType: otpSendType ?? this.otpSendType,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}
