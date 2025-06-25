// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/user_place_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';
import '../entities/place_entity.dart';

class SearchPlaces {
  final CreatePostRepo createPostRepo;

  SearchPlaces({required this.createPostRepo});

  Future<Either<Failure,UserPlaceResultEntity>> call({required String search,required int page,required int perPage}) async {
    final res = await createPostRepo.searchPlaces(search: search,perPage: perPage,page: page);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
