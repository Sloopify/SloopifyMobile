// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';

class GetFeelingsUseCase {
  final CreatePostRepo createPostRepo;

  GetFeelingsUseCase({required this.createPostRepo});

  Future<Either<Failure, List<FeelingEntity>>> call() async {
    final res = await createPostRepo.getFeelings();
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
