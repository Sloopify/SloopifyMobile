// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/forget_password_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';

class ChangePasswordUseCase {
  final AccountRepo accountsRepo;
  ChangePasswordUseCase({
    required this.accountsRepo,
  });
  Future<Either<Failure, Unit>> call({
    required ForgetPasswordDataEntity forgetPasswordDataEntity,
  }) async {
    final res = await accountsRepo.changePassword(
      forgetPasswordDataEntity: forgetPasswordDataEntity,
    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
