import 'package:sloopify_mobile/features/auth/domain/entities/signup_data_entity.dart';

class SignUpDataModel extends SignupDataEntity {

  const SignUpDataModel({
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
    };
  }
}
