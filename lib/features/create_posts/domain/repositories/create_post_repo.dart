import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activity_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/categories_activity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/friends_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/regular_post_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/user_place_result_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class CreatePostRepo{
  Future<Either<Failure, FriendsResultEntity>> getFriendsList({required int perPage,required int page});

  Future<Either<Failure, FriendsResultEntity>>  searchFriendsList({required String friendName,required int page,required int perPage});

  Future<Either<Failure, FeelingResultEntity>>  searchFeeling({required String feelingName,required int page,required int perPage});

  Future<Either<Failure,FeelingResultEntity>>  getFeelings({required int page,required int perPage});

  Future<Either<Failure, ActivityCategoriesResult>> getActivityCategories({required int page,required int perPage});

  Future<Either<Failure,ActivityResultEntity>> searchActivities({required String name,required int page,required int perPage});

  Future<Either<Failure, ActivityResultEntity>>  getActivitiesByCategoryName({
    required int page,
    required int perPage,
    required String categoryName,
  });

  Future<Either<Failure, ActivityCategoriesResult>> searchActivitiesCategoriesByName({
    required String name,
    required int page,
    required int perPage
  });
  Future<Either<Failure, UserPlaceResultEntity>> getUserPlaces({required int page,required int perPage});
  Future<Either<Failure, PlaceEntity>> getPlaceById({required String placeId});
  Future<Either<Failure, UserPlaceResultEntity>> searchPlaces({required String search,required int page,required int perPage});
  Future<Either<Failure, Unit>> createPlace({required CreatePlaceEntity  createPlaceEntity});
  Future<Either<Failure, Unit>> updatePlace({required CreatePlaceEntity  createPlaceEntity});
  Future<Either<Failure, Unit>> createPost({required RegularPostEntity  regularPostEntity});


}