// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_story/domain/repository/create_story_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../create_posts/domain/entities/place_entity.dart';

class GetStoryUserPlaceByIdUseCase {
  final CreateStoryRepo createStoryRepo;

  GetStoryUserPlaceByIdUseCase({required this.createStoryRepo});

  Future<Either<Failure, PlaceEntity>> call({required String placeId}) async {
    final res = await createStoryRepo.getPlaceById(placeId: placeId);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
