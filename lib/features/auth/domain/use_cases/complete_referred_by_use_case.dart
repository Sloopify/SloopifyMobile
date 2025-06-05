// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';

class CompleteReferredByUseCase {
  final AccountRepo accountsRepo;

  CompleteReferredByUseCase({required this.accountsRepo});

  Future<Either<Failure, Unit>> call({
    required String referredBy,
  }) async {
    final res = await accountsRepo.completeReferredBy(referredByCode: referredBy);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
