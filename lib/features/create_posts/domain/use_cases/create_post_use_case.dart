// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/regular_post_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';

class CreatePostUseCase {
  final CreatePostRepo createPostRepo;

  CreatePostUseCase({required this.createPostRepo});

  Future<Either<Failure, Unit>> call({required RegularPostEntity regularPostEntity}) async {
    final res = await createPostRepo.createPost(regularPostEntity: regularPostEntity);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
