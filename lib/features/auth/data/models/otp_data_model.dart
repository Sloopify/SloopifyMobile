import 'package:sloopify_mobile/core/utils/helper/app_extensions/otp_send_type_extension.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';

class OtpDataModel extends OtpDataEntity {
  const OtpDataModel({
    required super.type,
    super.email,
    super.phoneNumbers,
    required super.countryCode,
    required super.fullPhoneNumber,
  });

  toJson() {
    return {
      if (email != null && email!.isNotEmpty && type == OtpSendType.email)
        "email": email,
      if (fullPhoneNumber != null &&
          fullPhoneNumber!.isNotEmpty &&
          type == OtpSendType.phone) "phone": fullPhoneNumber,
      "type": type.getText(),
    };
  }
}
