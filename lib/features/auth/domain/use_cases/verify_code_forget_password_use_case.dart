// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/auth_repo.dart';

import '../../../../core/errors/failures.dart';

class VerifyCodeForgetPasswordUseCase {
  final AccountRepo accountsRepo;

  VerifyCodeForgetPasswordUseCase({
    required this.accountsRepo,
  });

  Future<Either<Failure, Unit>> call({
    required VerifyOtpEntity verifyOtpEntity,
  }) async {
    final res = await accountsRepo.verifyCodeForForgetPassword(
      verifyOtpEntity: verifyOtpEntity,
    );
    return res.fold((f) => Left(f), (r) async {
      return Right(r);
    });
  }
}
