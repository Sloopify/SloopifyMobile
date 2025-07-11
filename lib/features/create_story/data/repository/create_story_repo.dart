import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/core/errors/failures.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/create_place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/friends_result_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/place_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/user_place_result_entity.dart';
import 'package:sloopify_mobile/features/create_story/data/create_stoty_provider/create_story_data_provider.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/audio_result_enitity.dart';
import 'package:sloopify_mobile/features/create_story/domain/repository/create_story_repository.dart';

import '../../../../core/api_service/base_repo.dart';

class CreateStoryRepoImpl extends CreateStoryRepo{
  final CreateStoryDataProvider createStoryDataProvider;
  CreateStoryRepoImpl({required this.createStoryDataProvider});
  @override
  Future<Either<Failure, FriendsResultEntity>> getFriendsList({required int perPage, required int page}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.getFriendsList(page: page,perPage: perPage);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, FriendsResultEntity>> searchFriendsList({required String friendName, required int page, required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.searchFriendsList(page: page,perPage: perPage,friendName: friendName);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, FeelingResultEntity>> getFeelings({required int page, required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.getFeelings(page: page,perPage: perPage,);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, FeelingResultEntity>> searchFeeling({required String feelingName, required int page, required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.searchFeeling(page: page,perPage: perPage,feelingName: feelingName);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> createPlace({required CreatePlaceEntity createPlaceEntity}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.createPlace(createPlaceEntity: createPlaceEntity);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, PlaceEntity>> getPlaceById({required String placeId}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.getUserPlaceById(placeId: placeId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, UserPlaceResultEntity>> getUserPlaces({required int page, required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.getUserPlaces(page: page,perPage: perPage);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, UserPlaceResultEntity>> searchPlaces({required String search, required int page, required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.searchPlaces(page: page,perPage: perPage,search: search);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, Unit>> updatePlace({required CreatePlaceEntity createPlaceEntity}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.updateUserPlace(createPlaceEntity:createPlaceEntity);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, AudioResultEntity>> getStoryAudios({required int page, required int perPage}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.getStoryAudios(page:page,perPage: perPage);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }

  @override
  Future<Either<Failure, AudioResultEntity>> searchStoryAudios({required int page, required int perPage, required String search}) async {
    final data = await BaseRepo.repoRequest(
      request: () async {
        return await createStoryDataProvider.searchStoryAudio(perPage: perPage,search: search,page: page);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));
  }
  
}