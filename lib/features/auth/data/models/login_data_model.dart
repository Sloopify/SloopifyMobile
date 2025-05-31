import 'package:sloopify_mobile/features/auth/domain/entities/login_data_entity.dart';

class LoginDataModel extends LoginDataEntity {
  const LoginDataModel({
    required super.password,
    required super.rememberMe,
    super.email,
    super.phoneNumber, required super.loginType,super.countryCode,super.fullFormatedNumber
  });

  toJson() {
    return {
      "password": password,
      if (email != null &&email!.isNotEmpty && loginType==LoginType.email) "email": email,
      if (loginType==LoginType.phoneNumber && fullFormatedNumber!=null &&fullFormatedNumber!.isNotEmpty) "phone":fullFormatedNumber,
    };
  }
}
