// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';
import '../reposritory/auth_repo.dart';

class EmailLoginUseCase {
  final AccountRepo accountsRepo;
  final AuthRepo authRepo;

  EmailLoginUseCase({
    required this.accountsRepo,
    required this.authRepo
  });
  Future<Either<Failure, LoginEntity>> call({
    required LoginDataEntity loginDataEntity,
  }) async {
    final res = await accountsRepo.loginWithEmail(
      loginDataEntity: loginDataEntity,
    );
    return res.fold((f) => Left(f), (r) async {
      await authRepo.saveUserInfo(r.userEntity);
      return Right(r);
    });
  }
}
