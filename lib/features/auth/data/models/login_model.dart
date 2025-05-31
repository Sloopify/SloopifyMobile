import 'package:sloopify_mobile/features/auth/data/models/on_boarding_data_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/user_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({required super.onBoardingDataInfo, required super.userEntity});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      onBoardingDataInfo:
      OnBoardingDataModel.fromJson(
        json["completed_on_boarding"],
      ),
      userEntity: UserModel.fromJson(json["user"]),
    );
  }
}
