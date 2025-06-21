import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/regular_post_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class CreatePostRepo{
  Future<Either<Failure, List<UserEntity>>> getFriendsList();

  Future<Either<Failure, List<UserEntity>>>  searchFriendsList({required String friendName});

  Future<Either<Failure, List<FeelingEntity>>>  searchFeeling({required String feelingName});

  Future<Either<Failure, List<FeelingEntity>>>  getFeelings();

  Future<Either<Failure, List<dynamic>>> getActivityCategories();

  Future<Either<Failure, List<ActivityEntity>>> searchActivities({required String name});

  Future<Either<Failure, List<ActivityEntity>>>  getActivitiesByCategoryName({
    required String categoryName,
  });

  Future<Either<Failure, List<dynamic>>> searchActivitiesCategoriesByName({
    required String name,
  });
  Future<Either<Failure, List<PlaceEntity>>> getUserPlaces();
  Future<Either<Failure, PlaceEntity>> getPlaceById({required String placeId});
  Future<Either<Failure, List<PlaceEntity>>> searchPlaces({required String search});
  Future<Either<Failure, Unit>> createPlace({required CreatePlaceEntity  createPlaceEntity});
  Future<Either<Failure, Unit>> updatePlace({required CreatePlaceEntity  createPlaceEntity});
  Future<Either<Failure, Unit>> createPost({required RegularPostEntity  regularPostEntity});


}