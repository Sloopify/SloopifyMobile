// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/auth_repo.dart';

import '../../../../core/errors/failures.dart';

class VerifyOtpCodeLogin {
  final AccountRepo accountsRepo;
  final AuthRepo authRepo;
  VerifyOtpCodeLogin({
    required this.accountsRepo,
    required this.authRepo
  });
  Future<Either<Failure, LoginEntity>> call({
    required VerifyOtpEntity verifyOtpEntity,
  }) async {
    final res = await accountsRepo.verifyLoginWithOtp(
      verifyOtpEntity: verifyOtpEntity,
    );
    return res.fold((f) => Left(f), (r) async {
      await authRepo.saveUserInfo(r.userEntity);
      return Right(r);
    });
  }
}
