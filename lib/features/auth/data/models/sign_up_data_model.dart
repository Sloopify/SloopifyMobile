import 'package:sloopify_mobile/features/auth/domain/entities/signup_data_entity.dart';

class SignUpDataModel extends SignupDataEntity {
  final String deviceId;
  final String deviceType;

  const SignUpDataModel({
    required this.deviceId,
    required this.deviceType,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.password,
    required super.confirmPassword,
    required super.isCheckedTerms,
    required super.mobileNumber,
    required super.countryCode, required super.fullPhoneNumber,
  });

  toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone": fullPhoneNumber,
      if(deviceId.isNotEmpty) "deviceId": deviceId,
      if(deviceType.isNotEmpty) "deviceType": deviceType,
    };
  }
}
