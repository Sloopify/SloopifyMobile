// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';

class SearchFeelingsUseCase {
  final CreatePostRepo createPostRepo;

  SearchFeelingsUseCase({required this.createPostRepo});

  Future<Either<Failure, List<FeelingEntity>>> call({required String name}) async {
    final res = await createPostRepo.searchFeeling(feelingName: name);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
