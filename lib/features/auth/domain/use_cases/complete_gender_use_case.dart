// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/interets_data_result.dart';
import '../entities/user_profile_entity.dart';

class CompleteGenderUseCase {
  final AccountRepo accountsRepo;

  CompleteGenderUseCase({required this.accountsRepo});

  Future<Either<Failure, Unit>> call({
    required Gender gender,
  }) async {
    final res = await accountsRepo.completeGender(gender: gender);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
