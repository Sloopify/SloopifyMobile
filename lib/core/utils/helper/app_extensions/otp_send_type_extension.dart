import '../../../../features/auth/domain/entities/otp_data_entity.dart';

extension SendOtpTypeExtension on OtpSendType {
  String getText() {
    switch (this) {
      case OtpSendType.email:
        return "email";
      case OtpSendType.phone:
        return "phone";
      case OtpSendType.none:
        // TODO: Handle this case.
        throw "";
    }
  }
}
