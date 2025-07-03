import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sloopify_mobile/core/api_service/api_urls.dart';
import 'package:sloopify_mobile/core/api_service/base_api_service.dart';
import 'package:sloopify_mobile/features/auth/data/models/forget_password_data_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/login_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/sign_up_data_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_profile_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/device_info_api.dart';
import '../models/interests_data_result_model.dart';
import '../models/login_data_model.dart';
import '../models/otp_data_model.dart';
import '../models/verify_otp_data_model.dart';

abstract class AccountsDataProvider {
  Future<Unit> signup({required SignUpDataModel signupData});

  Future<Unit> sendOtpCode({required OtpDataModel otpData});

  Future<Unit> verifyOtpCode({required VerifyOtpDataModel verifyOtpData});

  Future<LoginModel> loginWithEmail({required LoginDataModel loginDataModel});

  Future<LoginModel> loginWithPhone({required LoginDataModel loginDataModel});

  Future<Unit> loginWithOtp({required OtpDataModel otpDateModel});

  Future<LoginModel> verifyLoginWithOtp({
    required VerifyOtpDataModel verifyOtpDataModel,
  });

  Future<LoginModel> verifyUserToken();

  Future<InterestsDataResultModel> getInterests({
    required int pageNumber,
    required int perPage,
    required String categoryName,
  });

  Future<List<dynamic>> getAllCategories();

  Future<Unit> completeInterests({required List<String> selectedIds});

  Future<Unit> completeGender({required Gender gender});

  Future<Unit> completeBirthDay({required DateTime bornDate});

  Future<Unit> completeImage({required File image});

  Future<Unit> completeByReferredCode({required String code});

  Future<Unit> requestSendOtpCodeForForgetPassword({
    required OtpDataModel otpDataModel,
  });

  Future<Unit> verifyOtpCodeForForgetPassword({
    required VerifyOtpDataModel verifyOtpModel,
  });

  Future<Unit> changePassword({
    required ForgetPasswordModel forgetPasswordModel,
  });
}

class AccountsDataProviderImpl extends AccountsDataProvider {
  final BaseApiService client;

  AccountsDataProviderImpl({required this.client});

  @override
  Future<Unit> sendOtpCode({required OtpDataModel otpData}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.sendOtpByRegister,
      jsonBody: otpData.toJson(),
    );
    if (res["success"] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['errors'] ?? res["message"];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if ((errors[e] as List<dynamic>).isNotEmpty) {
            errorMessage += errors[e].first + '\n';
          }
        });
      }
      throw NetworkErrorFailure(message:errorMessage);
    }
  }

  @override
  Future<Unit> signup({required SignUpDataModel signupData}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.signUp,
      jsonBody: signupData.toJson(),
    );
    if (res['success'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['errors'] ?? res["message"];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if ((errors[e] as List<dynamic>).isNotEmpty) {
            errorMessage += errors[e].first + '\n';
          }
        });
      }
      throw NetworkErrorFailure(message: errorMessage);
    }
  }

  @override
  Future<Unit> verifyOtpCode({
    required VerifyOtpDataModel verifyOtpData,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.verifyOtpByRegister,
      jsonBody: verifyOtpData.toJson(),
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<LoginModel> loginWithEmail({
    required LoginDataModel loginDataModel,
  }) async {
    final resInfo = await getDeviceInfo();

    if (resInfo.isLeft()) {
      throw NetworkErrorFailure(message: "");
    }

    final deviceInfo = resInfo.getOrElse(() => throw NetworkErrorFailure(message: ""));
    String deviceInfoModel = deviceInfo.$1;
    String operationSystemVersion = deviceInfo.$2;
    String deviceId = deviceInfo.$3;

    final res = await client.multipartRequest(
      url: ApiUrls.loginWithEmail,
      jsonBody: loginDataModel.toJson(),
      headers: {
        "App-Type": "mobile",
        "Device-Model": deviceInfoModel,
        "Platform": operationSystemVersion,
        "Device-ID": deviceId,
      },
    );

    if (res["success"] == true) {
      return LoginModel.fromJson(res["data"]);
    } else {
      String errorMessage = '';
      final errors = res['errors'] ?? res["message"];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if(errors[e] is String){
            if ((errors[e] as String).isNotEmpty) {
              errorMessage += errors[e] + '\n';
            }
          }else if (errors[e] is List<dynamic>){
            if ((errors[e] as List<dynamic>).isNotEmpty) {
              errorMessage += errors[e].first + '\n';
            }
          }

        });
      }
      throw NetworkErrorFailure(message: errorMessage);
    }
  }

  @override
  Future<Unit> loginWithOtp({required OtpDataModel otpDateModel}) async {
    final resInfo = await getDeviceInfo();

    if (resInfo.isLeft()) {
      throw NetworkErrorFailure(message: "");
    }

    final deviceInfo = resInfo.getOrElse(() => throw NetworkErrorFailure(message: ""));
    String deviceInfoModel = deviceInfo.$1;
    String operationSystemVersion = deviceInfo.$2;
    String deviceId = deviceInfo.$3;
    final res = await client.multipartRequest(
      url: ApiUrls.loginWithOtp,
      jsonBody: otpDateModel.toJson(),
      headers: {
        "App-Type": "mobile",
        "Device-Model": deviceInfoModel,
        "Platform": operationSystemVersion,
        "Device-ID": deviceId,
      },
    );
    if (res["success"] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['errors'] ?? res["message"];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if ((errors[e] as String).isNotEmpty) {
            errorMessage += errors[e] + '\n';
          }
        });
      }
      throw NetworkErrorFailure(message: errorMessage);
    }
  }

  @override
  Future<LoginModel> loginWithPhone({
    required LoginDataModel loginDataModel,
  }) async {
    final resInfo = await getDeviceInfo();

    if (resInfo.isLeft()) {
      throw NetworkErrorFailure(message: "");
    }

    final deviceInfo = resInfo.getOrElse(() => throw NetworkErrorFailure(message: ""));
    String deviceInfoModel = deviceInfo.$1;
    String operationSystemVersion = deviceInfo.$2;
    String deviceId = deviceInfo.$3;
    final res = await client.multipartRequest(
      url: ApiUrls.loginWithPhone,
      jsonBody: loginDataModel.toJson(),
      headers: {
        "App-Type": "mobile",
        "Device-Model": deviceInfoModel,
        "Platform": operationSystemVersion,
        "Device-ID": deviceId,
      },

    );

    if (res["success"] == true) {
      return LoginModel.fromJson(res["data"]);
    } else {
      String errorMessage = '';
      final errors = res['errors'] ?? res["message"];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if ((errors[e] as List<dynamic>).isNotEmpty) {
            errorMessage += errors[e].first + '\n';
          }
        });
      }
      throw NetworkErrorFailure(message: errorMessage);
    }
  }

  @override
  Future<LoginModel> verifyLoginWithOtp({
    required VerifyOtpDataModel verifyOtpDataModel,
  }) async {
    final resInfo = await getDeviceInfo();

    if (resInfo.isLeft()) {
      throw NetworkErrorFailure(message: "");
    }

    final deviceInfo = resInfo.getOrElse(() => throw NetworkErrorFailure(message: ""));
    String deviceInfoModel = deviceInfo.$1;
    String operationSystemVersion = deviceInfo.$2;
    String deviceId = deviceInfo.$3;
    final res = await client.multipartRequest(
      url: ApiUrls.verifyLoginWithOtp,
      jsonBody: verifyOtpDataModel.toJson(),
      headers: {
        "App-Type": "mobile",
        "Device-Model": deviceInfoModel,
        "Platform": operationSystemVersion,
        "Device-ID": deviceId,
      },
    );
    if (res["success"] == true) {
      return LoginModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<LoginModel> verifyUserToken() async {
    final res = await client.multipartRequest(
      url: ApiUrls.verifyUserToken,
      jsonBody: {},
    );
    if (res["success"] == true) {
      return LoginModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<InterestsDataResultModel> getInterests({
    required int pageNumber,
    required int perPage,
    required String categoryName,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getInterests,
      jsonBody: {
        "perPage": perPage.toString(),
        "page": pageNumber.toString(),
        "category_name": categoryName,
      },
    );
    if (res["success"] == true) {
      return InterestsDataResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<dynamic>> getAllCategories() async {
    final res = await client.getRequest(url: ApiUrls.getAllCategories);
    if (res["success"] == true) {
      return res["data"];
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> completeBirthDay({required DateTime bornDate}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.completeBirthDay,
      jsonBody: {
        "birthday": "${bornDate.year}-${bornDate.month}-${bornDate.day}",
      },
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> completeGender({required Gender gender}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.completeGender,
      jsonBody: {"gender": gender == Gender.female ? "female" : "male"},
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> completeInterests({required List<String> selectedIds}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.completeInterests,
      jsonBody: {"interests": selectedIds},
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> completeByReferredCode({required String code}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.completeRefferDay,
      jsonBody: {"referred_by_code": code},
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> completeImage({required File image}) async {
    final body = {'image': await MultipartFile.fromFile(image.path)};

    final res = await client.uploadFiles(
      url: ApiUrls.completeImage,
      jsonBody: body,
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> changePassword({
    required ForgetPasswordModel forgetPasswordModel,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.changePassword,
      jsonBody: forgetPasswordModel.toJson(),
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> requestSendOtpCodeForForgetPassword({
    required OtpDataModel otpDataModel,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.requestCodeForForgetPassword,
      jsonBody: otpDataModel.toJson(),
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> verifyOtpCodeForForgetPassword({
    required VerifyOtpDataModel verifyOtpModel,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.verifyCodeForForgetPassword,
      jsonBody: verifyOtpModel.toJson(),
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }
}

Future<Either<Failure, (String, String, String)>> getDeviceInfo() async {
  String? deviceModelInfo = await DeviceInfoApi.getDeviceInfo();
  String? deviceId = await DeviceInfoApi.getDeviceId();
  String? operationSystem = await DeviceInfoApi.getOperatingSystem();
  return Right(('$deviceModelInfo', operationSystem, "$deviceId"));
}
