// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activity_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';

class SearchActivitiesByNameUseCase {
  final CreatePostRepo createPostRepo;

  SearchActivitiesByNameUseCase({required this.createPostRepo});

  Future<Either<Failure, ActivityResultEntity>> call({required String name,required int page,required int perPage}) async {
    final res = await createPostRepo.searchActivities(name: name,perPage: perPage,page: page);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
