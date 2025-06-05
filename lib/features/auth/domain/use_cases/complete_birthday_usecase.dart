// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';

class CompleteBirthdayUseCase {
  final AccountRepo accountsRepo;

  CompleteBirthdayUseCase({required this.accountsRepo});

  Future<Either<Failure, Unit>> call({
    required DateTime bornDate,
  }) async {
    final res = await accountsRepo.completeBirthDay(bornDate: bornDate);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
