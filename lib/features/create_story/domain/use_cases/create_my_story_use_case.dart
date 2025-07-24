// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/story_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/repository/create_story_repository.dart';

import '../../../../core/errors/failures.dart';

class CreateMyStoryUseCase {
  final CreateStoryRepo createStoryRepo;

  CreateMyStoryUseCase({required this.createStoryRepo});

  Future<Either<Failure, Unit>> call({required StoryEntity storyEntity}) async {
    final res = await createStoryRepo.createMyStory(storyEntity: storyEntity);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
