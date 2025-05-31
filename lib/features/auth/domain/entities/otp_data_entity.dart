import 'package:equatable/equatable.dart';

enum OtpSendType { email, phone ,none}

class OtpDataEntity extends Equatable {
  final OtpSendType type;
  final String? email;
  final String? phoneNumbers;
  final String ? countryCode;
  final String? fullPhoneNumber;

  const OtpDataEntity({required this.type, this.phoneNumbers, this.email,required this.countryCode,required this.fullPhoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [type, email, phoneNumbers,countryCode,fullPhoneNumber];

  factory OtpDataEntity.fromEmpty() {
    return OtpDataEntity(
      countryCode: "+963",
      fullPhoneNumber: "",
      type:OtpSendType.email,
      email: null,
      phoneNumbers: "",
    );
  }

  OtpDataEntity copyWith(
  {
    OtpSendType? type,
    String? email,
    String? phoneNumbers,
    String? countryCode,
    String ? fullPhoneNumber,
}
  ) {
    return OtpDataEntity(
      fullPhoneNumber: fullPhoneNumber??this.fullPhoneNumber,
      countryCode: countryCode??this.countryCode,
      type: type ?? this.type,
      email: email ?? this.email,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
    );
  }
}
