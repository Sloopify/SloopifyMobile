// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/repository/create_story_repository.dart';

import '../../../../core/errors/failures.dart';

class UpdateStoryUserPlace {
  final CreateStoryRepo createStoryRepo;

  UpdateStoryUserPlace({required this.createStoryRepo});

  Future<Either<Failure, Unit>> call({required CreatePlaceEntity createPlaceEntity}) async {
    final res = await createStoryRepo.updatePlace(createPlaceEntity: createPlaceEntity);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
