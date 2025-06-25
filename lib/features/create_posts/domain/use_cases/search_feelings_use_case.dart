// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';

class SearchFeelingsUseCase {
  final CreatePostRepo createPostRepo;

  SearchFeelingsUseCase({required this.createPostRepo});

  Future<Either<Failure, FeelingResultEntity>> call({required String name,required int page,required int perPage}) async {
    final res = await createPostRepo.searchFeeling(feelingName: name,perPage: perPage,page: page);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
