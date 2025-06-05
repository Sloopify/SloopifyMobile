import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/forget_password_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/verify_otp_entity.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interets_data_result.dart';
import '../entities/login_data_entity.dart';
import '../entities/signup_data_entity.dart';
import '../entities/user_profile_entity.dart';

abstract class AccountRepo {
  Future<Either<Failure, Unit>> signup({
    required SignupDataEntity signupDataEntity,
  });

  Future<Either<Failure, Unit>> sendOtp({required OtpDataEntity otpDataEntity});

  Future<Either<Failure, Unit>> verifyOtpCode({
    required VerifyOtpEntity verifyOtpEntity,
  });

  Future<Either<Failure, LoginEntity>> loginWithEmail({
    required LoginDataEntity loginDataEntity,
  });

  Future<Either<Failure, LoginEntity>> loginWithPhone({
    required LoginDataEntity loginDataEntity,
  });

  Future<Either<Failure, Unit>> loginWithOtp({
    required OtpDataEntity otpDataEntity,
  });

  Future<Either<Failure, LoginEntity>> verifyLoginWithOtp({
    required VerifyOtpEntity verifyOtpEntity,
  });

  Future<Either<Failure, LoginEntity>> verifyUserToken();

  Future<Either<Failure, InterestsDataResult>> getInterests({
    required int pageNumber,
    required int perPage,
    required String categoryName,
  });

  Future<Either<Failure, List<dynamic>>> getAllCategories();

  Future<Either<Failure, Unit>> completeInterests({
    required List<String> selectedIds,
  });
  Future<Either<Failure, Unit>> completeGender({
    required Gender gender ,
  });
  Future<Either<Failure, Unit>> completeBirthDay({
    required DateTime bornDate ,
  });
  Future<Either<Failure, Unit>> completeProfileImage({
    required File image ,
  });
  Future<Either<Failure, Unit>> completeReferredBy({
    required String referredByCode ,
  });
  Future<Either<Failure, Unit>> requestCodeForForgetPassword({
    required OtpDataEntity otpDataEntity ,
  });
  Future<Either<Failure, Unit>> verifyCodeForForgetPassword({
    required VerifyOtpEntity verifyOtpEntity ,
  });
  Future<Either<Failure, Unit>> changePassword({
    required ForgetPasswordDataEntity forgetPasswordDataEntity ,
  });
}
