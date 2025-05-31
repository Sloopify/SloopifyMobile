import 'package:sloopify_mobile/core/utils/helper/app_extensions/otp_send_type_extension.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/verify_otp_entity.dart';

class VerifyOtpDataModel extends VerifyOtpEntity {
  VerifyOtpDataModel({
    required super.otp,
    required super.otpSendType,
    super.email,
    super.phone,
  });

  toJson() {
    return {
      if (email!.isNotEmpty && email != null && otpSendType==OtpSendType.email) "email": email,
      if (phone != null && phone!.isNotEmpty &&otpSendType==OtpSendType.phone) "phone": phone,
      "type": otpSendType.getText(),
      "otp": otp,
    };
  }
}
