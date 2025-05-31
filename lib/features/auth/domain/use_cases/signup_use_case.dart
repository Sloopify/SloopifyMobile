// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/data/repositories/account_repo_impl.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/signup_data_entity.dart';

class SignupUseCase {
  final AccountRepo accountsRepo;
  SignupUseCase({
    required this.accountsRepo,
  });
  Future<Either<Failure, Unit>> call({
    required SignupDataEntity signupDataEntity,
  }) async {
    final res = await accountsRepo.signup(
      signupDataEntity: signupDataEntity,
    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
