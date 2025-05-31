import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/core/api_service/api_urls.dart';
import 'package:sloopify_mobile/core/api_service/base_api_service.dart';
import 'package:sloopify_mobile/features/auth/data/models/login_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/sign_up_data_model.dart';

import '../../../../core/errors/failures.dart';
import '../models/login_data_model.dart';
import '../models/otp_data_model.dart';
import '../models/verify_otp_data_model.dart';

abstract class AccountsDataProvider {

  Future<Unit> signup({required SignUpDataModel signupData});
  Future<Unit> sendOtpCode({required OtpDataModel otpData });
  Future<Unit> verifyOtpCode({required VerifyOtpDataModel verifyOtpData});
  Future<LoginModel> loginWithEmail({required  LoginDataModel loginDataModel });
  Future<LoginModel> loginWithPhone({required  LoginDataModel loginDataModel });
  Future<Unit> loginWithOtp({required  OtpDataModel otpDateModel });
  Future<LoginModel> verifyLoginWithOtp({required  VerifyOtpDataModel verifyOtpDataModel });
  Future<LoginModel> verifyUserToken();


}

class AccountsDataProviderImpl extends AccountsDataProvider{
  final BaseApiService client;
  AccountsDataProviderImpl({required this.client});

  @override
  Future<Unit> sendOtpCode({required OtpDataModel otpData}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.sendOtpByRegister,
      jsonBody: otpData.toJson(),
    );
    if(res["success"]==true){
      return unit;
    }else{
      throw NetworkErrorFailure(
        message: res['message'],
      );
    }
  }

  @override
  Future<Unit> signup({required SignUpDataModel signupData}) async{
    final res = await client.multipartRequest(
      url: ApiUrls.signUp,
      jsonBody: signupData.toJson(),
    );
    if (res['success'] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['errors']??res["message"];
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
      throw NetworkErrorFailure(
        message: errorMessage,
      );
    }
  }

  @override
  Future<Unit> verifyOtpCode({required VerifyOtpDataModel verifyOtpData}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.verifyOtpByRegister,
      jsonBody: verifyOtpData.toJson(),
    );
    if(res["success"]==true){
      return unit;
    }else{
      throw NetworkErrorFailure(
        message: res['message'],
      );
    }
  }

  @override
  Future<LoginModel> loginWithEmail({required LoginDataModel loginDataModel}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.loginWithEmail,
      jsonBody: loginDataModel.toJson(),
    );
    if(res["success"]==true){
      return LoginModel.fromJson(res["data"]);
    }else{
      throw NetworkErrorFailure(
        message: res['message'],
      );
    }
  }

  @override
  Future<Unit> loginWithOtp({required OtpDataModel otpDateModel}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.loginWithOtp,
      jsonBody: otpDateModel.toJson(),
    );
    if(res["success"]==true){
      return unit;
    }else{
      String errorMessage = '';
      final errors = res['errors']??res["message"];
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
  Future<LoginModel> loginWithPhone({required LoginDataModel loginDataModel}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.loginWithPhone,
      jsonBody: loginDataModel.toJson(),
    );
    if(res["success"]==true){
      return LoginModel.fromJson(res["data"]);
    }else{
      String errorMessage = '';
      final errors = res['errors']??res["message"];
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
      throw NetworkErrorFailure(
        message:errorMessage,
      );
    }
  }

  @override
  Future<LoginModel> verifyLoginWithOtp({required VerifyOtpDataModel verifyOtpDataModel}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.verifyLoginWithOtp,
      jsonBody: verifyOtpDataModel.toJson(),
    );
    if(res["success"]==true){
      return LoginModel.fromJson(res["data"]);
    }else{
      throw NetworkErrorFailure(
        message: res['message'],
      );
    }
  }

  @override
  Future<LoginModel> verifyUserToken() async {
    final res = await client.multipartRequest(
      url: ApiUrls.verifyUserToken, jsonBody: {},
    );
    if(res["success"]==true){
      return LoginModel.fromJson(res["data"]);
    }else{
      throw NetworkErrorFailure(
        message: res['message'],
      );
    }
  }

}