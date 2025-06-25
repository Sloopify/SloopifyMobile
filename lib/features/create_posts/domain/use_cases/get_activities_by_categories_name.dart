// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activity_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';

class GetActivitiesByCategoriesName {
  final CreatePostRepo createPostRepo;

  GetActivitiesByCategoriesName({required this.createPostRepo});

  Future<Either<Failure, ActivityResultEntity>> call({
    required String categoryName,
    required int page,
    required int perPage
  }) async {
    final res = await createPostRepo.getActivitiesByCategoryName(
      categoryName: categoryName,
      page: page,
      perPage: perPage
    );
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
