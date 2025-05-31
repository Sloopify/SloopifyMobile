import 'package:sloopify_mobile/features/auth/domain/entities/phone_number_entity.dart';

class PhoneNumberModel extends PhoneNumberEntity {
  const PhoneNumberModel({
    required super.code,
    required super.phoneNumber,
    required super.fullNumber,
    required super.isValid,
  });

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) {
    return PhoneNumberModel(
      code: json['code'] ?? "",
      phoneNumber: json["number"] ?? "",
      fullNumber: json["full"] ?? "",
      isValid: json["valid"] ?? false,
    );
  }

  toJson(){
    return{
      "code":code,
      "number":phoneNumber,
      "full":fullNumber,
      "valid":isValid
    };
  }
}
