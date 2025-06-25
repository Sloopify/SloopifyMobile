import 'package:logger/logger.dart';
import 'package:sloopify_mobile/core/local_storage/prefernces_key.dart';
import 'package:sloopify_mobile/features/auth/data/models/on_boarding_data_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/user_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/onboarding_data_info.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';

import '../../../../core/local_storage/preferene_utils.dart';
import '../../domain/reposritory/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {

  @override
  Future<bool> deleteUserInfo() async {
    return await PreferenceUtils.removeValue(SharedPrefsKey.userInfo);
  }

  @override
  UserEntity? getUserInfo() {
    dynamic data = PreferenceUtils.getObject(SharedPrefsKey.userInfo);
    if (data == null) {
      return null;
    }
    Map<String, dynamic> mappedData = data as Map<String, dynamic>;
    //Logger().i(mappedData);

    UserEntity userEntity = UserModel.fromJson(mappedData);
  //  Logger().i(userEntity.toString());
    //Logger().i(userEntity.image);
    return userEntity;
  }

  @override
  Future<bool> hasUserInfo() {
    return PreferenceUtils.hasValue(SharedPrefsKey.userInfo);
  }

  @override
  Future<void> saveUserInfo(UserEntity user) async {
    UserModel userModel = UserModel(
        email: user.email,
        status: user.status,
        id: user.id,
        creationDate: user.creationDate,
        image: user.image,
        bio: user.bio,
        gender: user.gender,
        age: user.age,
        birthDate: user.birthDate,
        city: user.country,
        country: user.country,
        emailVerified: user.emailVerified,
        firstName: user.firstName,
        lastLoginDate: user.lastLoginDate,
        lastName: user.lastName,
        phoneNumberEntity: user.phoneNumberEntity,
        provider: user.provider,
        referralCode: user.referralCode,
        referralLink: user.referralLink,
        referredBy: user.referredBy,
        updatedAt: user.updatedAt
    );
    await PreferenceUtils.setObject(
        SharedPrefsKey.userInfo, userModel.toJson());
  }

  @override
  int? getUserId() {
    final UserEntity? userInfo = getUserInfo();
    if (userInfo != null) {
      return userInfo.id;
    } else {
      return null;
    }
  }

  @override
  String? getName() {
    final UserEntity? userInfo = getUserInfo();
    if (userInfo != null) {
      return "${userInfo.firstName} ${userInfo.lastName}";
    } else {
      return null;
    }
  }

  @override
  Future<void> updateActiveState() async {
    UserModel currentData = getUserInfo() as UserModel;
    UserModel newData = currentData.copyWith(status: "active");
    saveUserInfo(newData);
  }

  @override
  Future<void> saveCompleteUserInfo(OnBoardingDataInfo onBoardingData) async {
    OnBoardingDataModel onBoardingDataModel = OnBoardingDataModel(
        image: onBoardingData.image,
        gender: onBoardingData.gender,
        birthDay: onBoardingData.birthDay,
        interests: onBoardingData.interests);
    await PreferenceUtils.setObject(
        SharedPrefsKey.completedUserInfoData, onBoardingDataModel.toJson());
  }

  @override
  OnBoardingDataInfo? getCompletedUserInfo() {
    dynamic data = PreferenceUtils.getObject(SharedPrefsKey.completedUserInfoData);
    if (data == null) {
      return null;
    }
    Map<String, dynamic> mappedData = data as Map<String, dynamic>;
    Logger().i(mappedData);

    OnBoardingDataInfo onBoardingDataInfo = OnBoardingDataModel.fromJson(mappedData);
    Logger().i(onBoardingDataInfo.toString());
    return onBoardingDataInfo;
    //Logger().i(userEntity.ima
  }

  @override
  Future<bool> hesCompletedUserInfo() {
    return PreferenceUtils.hasValue(SharedPrefsKey.completedUserInfoData);

  }


}
