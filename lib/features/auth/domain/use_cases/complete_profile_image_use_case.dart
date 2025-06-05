// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';

import '../../../../core/errors/failures.dart';

class CompleteProfileImageUseCase {
  final AccountRepo accountsRepo;

  CompleteProfileImageUseCase({required this.accountsRepo});

  Future<Either<Failure, Unit>> call({
    required File image,
  }) async {
    final res = await accountsRepo.completeProfileImage(image: image);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
