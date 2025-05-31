import 'package:sloopify_mobile/features/auth/domain/entities/onboarding_data_info.dart';

class OnBoardingDataModel extends OnBoardingDataInfo {
  OnBoardingDataModel({
    required super.image,
    required super.gender,
    required super.birthDay,
    required super.interests,
  });

  factory OnBoardingDataModel.fromJson(Map<String, dynamic> json) {
    return OnBoardingDataModel(
      image: json["image"] ?? false,
      gender: json["gender"] ?? false,
      birthDay: json["birthday"] ?? false,
      interests: json["interests"] ?? false,
    );
  }

  toJson(){
    return{
      "image":image,
      "gender":gender,
      "birthday":birthDay,
      "interests":interests
    };
  }
}
