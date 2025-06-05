// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interets_data_result.dart';

class GetUserInterestsUseCase {
  final AccountRepo accountsRepo;

  GetUserInterestsUseCase({required this.accountsRepo});

  Future<Either<Failure, InterestsDataResult>> call({
    required int pageNumber,
    required int perPage,
    required String categoryName
  }) async {
    final res = await accountsRepo.getInterests(
      pageNumber: pageNumber,
      perPage: perPage,
      categoryName: categoryName
    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
