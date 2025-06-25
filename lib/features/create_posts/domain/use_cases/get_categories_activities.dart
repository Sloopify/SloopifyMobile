// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/categories_activity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';

class GetCategoriesActivities {
  final CreatePostRepo createPostRepo;

  GetCategoriesActivities({required this.createPostRepo});

  Future<Either<Failure, ActivityCategoriesResult>> call({required int page,required int perPage}) async {
    final res = await createPostRepo.getActivityCategories(perPage: perPage,page: page);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
