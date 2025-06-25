import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/core/errors/failures.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/data/create_post_data_provider/create_post_data_provider.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/categories_activity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/friends_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/regular_post_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/user_place_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/api_service/base_repo.dart';
import '../../domain/entities/activity_result_entity.dart';

class CreatePostRepoImpl extends CreatePostRepo {
  final CreatePostDataProvider createPostDataProvider;

  CreatePostRepoImpl({required this.createPostDataProvider});

  @override
  Future<Either<Failure, ActivityResultEntity>> getActivitiesByCategoryName({
    required String categoryName,
    required int page,required int perPage
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getActivitiesByCategoryName(
          perPage: perPage,
          page: page,

          categoryName: categoryName,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, ActivityCategoriesResult>> getActivityCategories({required int page,required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getActivityCategories(perPage: perPage,page: page);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, FeelingResultEntity>> getFeelings({required int page,required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getFeelings(page: page,perPage: perPage);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, FriendsResultEntity>> getFriendsList({required int page,required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getFriendsList(page: page,perPage: perPage);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, ActivityResultEntity>> searchActivities({
    required String name,
    required int page,
    required int perPage
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchActivities(name: name,perPage: perPage,page: page);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, ActivityCategoriesResult>> searchActivitiesCategoriesByName({
    required String name,
    required int page,
    required int perPage
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchActivitiesCategoriesByName(
          page: page,
          perPage: perPage,
          name: name,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, FeelingResultEntity>> searchFeeling({
    required String feelingName,
    required int page,
    required int perPage
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchFeeling(
          perPage:perPage ,page: page,

          feelingName: feelingName,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, FriendsResultEntity>> searchFriendsList({
    required String friendName,
    required int page,
    required int perPage
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchFriendsList(
          page: page,
          perPage: perPage,
          friendName: friendName,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> createPlace({
    required CreatePlaceEntity createPlaceEntity,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.createPlace(
          createPlaceEntity: createPlaceEntity,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, PlaceEntity>> getPlaceById({
    required String placeId,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getUserPlaceById(placeId: placeId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, UserPlaceResultEntity>> getUserPlaces({required int page,required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getUserPlaces(perPage: perPage,page: page);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, UserPlaceResultEntity>> searchPlaces({
    required String search,
    required int page,
    required int perPage
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchPlaces(page: page,
          perPage: perPage,
          search: search,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> updatePlace({
    required CreatePlaceEntity createPlaceEntity,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.updateUserPlace(
          createPlaceEntity: createPlaceEntity,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> createPost({required RegularPostEntity regularPostEntity}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.createPost(
          regularPostEntity: regularPostEntity,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
}
