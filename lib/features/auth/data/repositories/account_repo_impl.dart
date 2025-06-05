import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/core/errors/failures.dart';
import 'package:sloopify_mobile/features/auth/data/models/forget_password_data_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/login_data_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/otp_data_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/sign_up_data_model.dart';
import 'package:sloopify_mobile/features/auth/data/models/verify_otp_data_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/forget_password_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/interets_data_result.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/signup_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/api_service/base_repo.dart';
import '../../../../core/utils/device_info_api.dart';
import '../account_data_provider/account_data_provider.dart';

class AccountRepoImpl extends AccountRepo {
  final AccountsDataProvider accountsDataProvider;

  AccountRepoImpl({required this.accountsDataProvider});

  @override
  Future<Either<Failure, LoginEntity>> loginWithEmail({
    required LoginDataEntity loginDataEntity,
  }) async {
    LoginDataModel loginDataModel = LoginDataModel(
      password: loginDataEntity.password,
      loginType: loginDataEntity.loginType,
      countryCode: loginDataEntity.countryCode,
      rememberMe: loginDataEntity.rememberMe,
      email: loginDataEntity.email,
      phoneNumber: loginDataEntity.phoneNumber,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.loginWithEmail(
          loginDataModel: loginDataModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> loginWithOtp({
    required OtpDataEntity otpDataEntity,
  }) async {
    OtpDataModel otpDataModel = OtpDataModel(
      fullPhoneNumber: otpDataEntity.fullPhoneNumber,
      countryCode: otpDataEntity.countryCode,
      type: otpDataEntity.type,
      email: otpDataEntity.email,
      phoneNumbers: otpDataEntity.phoneNumbers,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.loginWithOtp(
          otpDateModel: otpDataModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, LoginEntity>> loginWithPhone({
    required LoginDataEntity loginDataEntity,
  }) async {
    LoginDataModel loginDataModel = LoginDataModel(
      loginType: loginDataEntity.loginType,
      countryCode: loginDataEntity.countryCode,
      password: loginDataEntity.password,
      rememberMe: loginDataEntity.rememberMe,
      email: loginDataEntity.email,
      phoneNumber: loginDataEntity.phoneNumber,
      fullFormatedNumber: loginDataEntity.fullFormatedNumber,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.loginWithPhone(
          loginDataModel: loginDataModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> sendOtp({
    required OtpDataEntity otpDataEntity,
  }) async {
    OtpDataModel otpDataModel = OtpDataModel(
      type: otpDataEntity.type,
      phoneNumbers: otpDataEntity.phoneNumbers,
      email: otpDataEntity.email,
      countryCode: otpDataEntity.countryCode,
      fullPhoneNumber: otpDataEntity.fullPhoneNumber,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.sendOtpCode(otpData: otpDataModel);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> signup({
    required SignupDataEntity signupDataEntity,
  }) async {
    String operationSystem = '';
    String deviceId = '';
    final res = await getDeviceInfo();
    return await res.fold(
      (f) {
        return Left(f);
      },
      (res) async {
        operationSystem += res.$1;
        deviceId += res.$2;
        SignUpDataModel signupDataModel = SignUpDataModel(
          fullPhoneNumber: signupDataEntity.fullPhoneNumber,
          password: signupDataEntity.password,
          confirmPassword: signupDataEntity.confirmPassword,
          isCheckedTerms: signupDataEntity.isCheckedTerms,
          email: signupDataEntity.email,
          mobileNumber: signupDataEntity.mobileNumber,
          countryCode: signupDataEntity.countryCode,
          deviceId: deviceId,
          deviceType: operationSystem,
          firstName: signupDataEntity.firstName,
          lastName: signupDataEntity.lastName,
        );
        final data = await BaseRepo.repoRequest(
          request: () async {
            return await accountsDataProvider.signup(
              signupData: signupDataModel,
            );
          },
        );
        return data.fold((f) => Left(f), (data) => Right(data));
      },
    );
  }

  @override
  Future<Either<Failure, LoginEntity>> verifyLoginWithOtp({
    required VerifyOtpEntity verifyOtpEntity,
  }) async {
    VerifyOtpDataModel verifyOtpDataModel = VerifyOtpDataModel(
      otp: verifyOtpEntity.otp,
      otpSendType: verifyOtpEntity.otpSendType,
      email: verifyOtpEntity.email,
      phone: verifyOtpEntity.phone,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.verifyLoginWithOtp(
          verifyOtpDataModel: verifyOtpDataModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> verifyOtpCode({
    required VerifyOtpEntity verifyOtpEntity,
  }) async {
    VerifyOtpDataModel verifyOtpDataModel = VerifyOtpDataModel(
      otp: verifyOtpEntity.otp,
      otpSendType: verifyOtpEntity.otpSendType,
      email: verifyOtpEntity.email,
      phone: verifyOtpEntity.phone,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.verifyOtpCode(
          verifyOtpData: verifyOtpDataModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  Future<Either<Failure, (String, String)>> getDeviceInfo() async {
    String? operatingSystem = DeviceInfoApi.getOperatingSystem();
    String? deviceId = await DeviceInfoApi.getDeviceId();
    return Right((operatingSystem, '$deviceId'));
  }

  @override
  Future<Either<Failure, LoginEntity>> verifyUserToken() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.verifyUserToken();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, InterestsDataResult>> getInterests({
    required int pageNumber,
    required int perPage,
    required String categoryName,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.getInterests(
          pageNumber: pageNumber,
          perPage: perPage,
          categoryName: categoryName,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<dynamic>>> getAllCategories() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.getAllCategories();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> completeBirthDay({
    required DateTime bornDate,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.completeBirthDay(bornDate: bornDate);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> completeGender({required Gender gender}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.completeGender(gender: gender);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> completeInterests({
    required List<String> selectedIds,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.completeInterests(
          selectedIds: selectedIds,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> completeProfileImage({
    required File image,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.completeImage(image: image);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> completeReferredBy({
    required String referredByCode,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.completeByReferredCode(
          code: referredByCode,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> changePassword({
    required ForgetPasswordDataEntity forgetPasswordDataEntity,
  }) async {
    ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel(
      confirmNewPassword: forgetPasswordDataEntity.confirmNewPassword,
      otpDataEntity: forgetPasswordDataEntity.otpDataEntity,
      newPassword: forgetPasswordDataEntity.newPassword,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.changePassword(
          forgetPasswordModel: forgetPasswordModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> requestCodeForForgetPassword({
    required OtpDataEntity otpDataEntity,
  }) async {
    OtpDataModel otpDataModel = OtpDataModel(
      fullPhoneNumber: otpDataEntity.fullPhoneNumber,
      countryCode: otpDataEntity.countryCode,
      type: otpDataEntity.type,
      email: otpDataEntity.email,
      phoneNumbers: otpDataEntity.phoneNumbers,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.requestSendOtpCodeForForgetPassword(
          otpDataModel: otpDataModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> verifyCodeForForgetPassword({
    required VerifyOtpEntity verifyOtpEntity,
  }) async {
    VerifyOtpDataModel verifyOtpDataModel = VerifyOtpDataModel(
      otp: verifyOtpEntity.otp,
      otpSendType: verifyOtpEntity.otpSendType,
      email: verifyOtpEntity.email,
      phone: verifyOtpEntity.phone,
    );
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await accountsDataProvider.verifyOtpCodeForForgetPassword(
          verifyOtpModel: verifyOtpDataModel,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
