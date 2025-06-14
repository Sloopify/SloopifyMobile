// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';

class GetUserPlaceByIdUseCase {
  final CreatePostRepo createPostRepo;

  GetUserPlaceByIdUseCase({required this.createPostRepo});

  Future<Either<Failure, PlaceEntity>> call({required String placeId}) async {
    final res = await createPostRepo.getPlaceById(placeId: placeId);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
