// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/user_place_result_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/repository/create_story_repository.dart';

import '../../../../core/errors/failures.dart';

class SearchStoryPlaces {
  final CreateStoryRepo createStoryRepo;

  SearchStoryPlaces({required this.createStoryRepo});

  Future<Either<Failure,UserPlaceResultEntity>> call({required String search,required int page,required int perPage}) async {
    final res = await createStoryRepo.searchPlaces(search: search,perPage: perPage,page: page);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
