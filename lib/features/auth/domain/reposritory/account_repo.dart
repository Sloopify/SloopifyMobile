import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/verify_otp_entity.dart';

import '../../../../core/errors/failures.dart';
import '../entities/login_data_entity.dart';
import '../entities/signup_data_entity.dart';

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
}
