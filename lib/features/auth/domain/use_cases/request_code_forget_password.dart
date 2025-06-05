// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';

class RequestCodeForgetPasswordUseCase {
  final AccountRepo accountsRepo;
  RequestCodeForgetPasswordUseCase({
    required this.accountsRepo,
  });
  Future<Either<Failure, Unit>> call({
    required OtpDataEntity otpDataEntity,
  }) async {
    final res = await accountsRepo.requestCodeForForgetPassword(
      otpDataEntity: otpDataEntity,
    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
