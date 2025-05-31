import 'package:sloopify_mobile/features/auth/domain/entities/onboarding_data_info.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  //save user info
  Future<void> saveUserInfo(UserEntity user);


  //get user info
  UserEntity? getUserInfo();

  //is there user info
  Future<bool> hasUserInfo();

  //delete user info
  Future<bool> deleteUserInfo();

  //update the isActive attribute state when the user verifies his account using otp
  Future<void> updateActiveState();

  Future<void> saveCompleteUserInfo(OnBoardingDataInfo onBoardingData);

  OnBoardingDataInfo? getCompletedUserInfo();
  Future<bool> hesCompletedUserInfo();


  //get user id
  int? getUserId();

  //get name
  String? getName();


}