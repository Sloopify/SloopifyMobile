import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/data/models/otp_data_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/forget_password_data_entity.dart';

class ForgetPasswordModel extends ForgetPasswordDataEntity {
  ForgetPasswordModel({
    required super.confirmNewPassword,
    required super.otpDataEntity,
    required super.newPassword,
  });

  toJson() {
    Map<String, dynamic> json = {};
    OtpDataModel otpDataModel = OtpDataModel(
      type: otpDataEntity.type,
      countryCode: otpDataEntity.countryCode,
      fullPhoneNumber: otpDataEntity.fullPhoneNumber,
      email: otpDataEntity.email,
      phoneNumbers: otpDataEntity.phoneNumbers,
    );
    json.addAll(otpDataModel.toJson());
    if(confirmNewPassword.isNotEmpty) json.putIfAbsent("confirm_password", ()=>confirmNewPassword);
    if(newPassword.isNotEmpty) json.putIfAbsent("password", ()=>newPassword);
    return json;
  }
}
