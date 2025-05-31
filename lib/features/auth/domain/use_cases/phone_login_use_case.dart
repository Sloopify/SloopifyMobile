// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';
import '../reposritory/auth_repo.dart';

class PhoneLoginUseCase {
  final AccountRepo accountsRepo;
  final AuthRepo authRepo;

  PhoneLoginUseCase({
    required this.accountsRepo,
    required this.authRepo
  });
  Future<Either<Failure, LoginEntity>> call({
    required LoginDataEntity loginDataEntity,
  }) async {
    final res = await accountsRepo.loginWithPhone(
      loginDataEntity: loginDataEntity,
    );
    return res.fold((f) => Left(f), (userData) async {
      await authRepo.saveUserInfo(userData.userEntity);
      return Right(userData);
    });
  }
}
