import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/core/errors/failures.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/data/create_post_data_provider/create_post_data_provider.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/api_service/base_repo.dart';

class CreatePostRepoImpl extends CreatePostRepo {
  final CreatePostDataProvider createPostDataProvider;

  CreatePostRepoImpl({required this.createPostDataProvider});

  @override
  Future<Either<Failure, List<ActivityEntity>>> getActivitiesByCategoryName({
    required String categoryName,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getActivitiesByCategoryName(
          categoryName: categoryName,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List>> getActivityCategories() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getActivityCategories();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<FeelingEntity>>> getFeelings() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getFeelings();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFriendsList() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getFriendsList();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<ActivityEntity>>> searchActivities({
    required String name,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchActivities(name: name);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List>> searchActivitiesCategoriesByName({
    required String name,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchActivitiesCategoriesByName(
          name: name,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<FeelingEntity>>> searchFeeling({
    required String feelingName,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchFeeling(
          feelingName: feelingName,
        );
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<UserEntity>>> searchFriendsList({
    required String friendName,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchFriendsList(
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
  Future<Either<Failure, List<PlaceEntity>>> getUserPlaces() async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.getUserPlaces();
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> searchPlaces({
    required String search,
  }) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createPostDataProvider.searchPlaces(
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
}
