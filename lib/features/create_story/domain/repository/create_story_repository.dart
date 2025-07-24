import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/audio_result_enitity.dart';

import '../../../../core/errors/failures.dart';
import '../../../create_posts/domain/entities/create_place_entity.dart';
import '../../../create_posts/domain/entities/feeling_result_entity.dart';
import '../../../create_posts/domain/entities/friends_result_entity.dart';
import '../../../create_posts/domain/entities/place_entity.dart';
import '../../../create_posts/domain/entities/user_place_result_entity.dart';
import '../entities/story_entity.dart';

abstract class CreateStoryRepo {
  Future<Either<Failure, FriendsResultEntity>> getFriendsList({
    required int perPage,
    required int page,
  });

  Future<Either<Failure, FriendsResultEntity>> searchFriendsList({
    required String friendName,
    required int page,
    required int perPage,
  });

  Future<Either<Failure, FeelingResultEntity>> searchFeeling({
    required String feelingName,
    required int page,
    required int perPage,
  });

  Future<Either<Failure, FeelingResultEntity>> getFeelings({
    required int page,
    required int perPage,
  });

  Future<Either<Failure, UserPlaceResultEntity>> getUserPlaces({
    required int page,
    required int perPage,
  });

  Future<Either<Failure, PlaceEntity>> getPlaceById({required String placeId});

  Future<Either<Failure, UserPlaceResultEntity>> searchPlaces({
    required String search,
    required int page,
    required int perPage,
  });

  Future<Either<Failure, Unit>> createPlace({
    required CreatePlaceEntity createPlaceEntity,
  });

  Future<Either<Failure, Unit>> updatePlace({
    required CreatePlaceEntity createPlaceEntity,
  });

  Future<Either<Failure, AudioResultEntity>> getStoryAudios({
    required int page,
    required int perPage,
  });

  Future<Either<Failure, AudioResultEntity>> searchStoryAudios({
    required int page,
    required int perPage,
    required String search,
  });

  Future<Either<Failure, Unit>> createMyStory({
    required StoryEntity storyEntity,
  });
}
