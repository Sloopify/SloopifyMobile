import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/create_story/data/models/audio_result_model.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/audio_result_enitity.dart';

import '../../../../core/api_service/api_urls.dart';
import '../../../../core/api_service/base_api_service.dart';
import '../../../../core/errors/failures.dart';
import '../../../create_posts/data/models/feelings_result_model.dart';
import '../../../create_posts/data/models/friends_result_model.dart';
import '../../../create_posts/data/models/place_model.dart';
import '../../../create_posts/data/models/user_places_result_model.dart';
import '../../../create_posts/domain/entities/create_place_entity.dart';

abstract class CreateStoryDataProvider {
  Future<FriendsResultModel> getFriendsList({
    required int page,
    required int perPage,
  });

  Future<FriendsResultModel> searchFriendsList({
    required String friendName,
    required int page,
    required int perPage,
  });

  Future<FeelingsResultModel> searchFeeling({
    required String feelingName,
    required int page,
    required int perPage,
  });

  Future<FeelingsResultModel> getFeelings({
    required int page,
    required int perPage,
  });
  Future<UserPlacesResultModel> getUserPlaces({
    required int page,
    required int perPage,
  });

  Future<PlaceModel> getUserPlaceById({required String placeId});

  Future<UserPlacesResultModel> searchPlaces({
    required String search,
    required int page,
    required int perPage,
  });

  Future<Unit> createPlace({required CreatePlaceEntity createPlaceEntity});

  Future<Unit> updateUserPlace({required CreatePlaceEntity createPlaceEntity});
  Future<Unit> deleteUserPlace({required int placeId});
  Future<AudioResultModel> getStoryAudios({required int page,required int perPage});
  Future<AudioResultModel> searchStoryAudio({required int page,required int perPage,required String search});


}

class CreateStoryDataProviderImpl extends CreateStoryDataProvider {
  final BaseApiService client;

  CreateStoryDataProviderImpl({required this.client});

  @override
  Future<FriendsResultModel> getFriendsList({
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getStoryFriends,
      jsonBody: {"page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return FriendsResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<FriendsResultModel> searchFriendsList({
    required String friendName,
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchStoryFriend,
      jsonBody: {"search": friendName, "page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return FriendsResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<FeelingsResultModel> getFeelings({
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getStoryFeeling,
      jsonBody: {"page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return FeelingsResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<FeelingsResultModel> searchFeeling({
    required String feelingName,
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchStoryFeeling,
      jsonBody: {"page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return FeelingsResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> createPlace({required CreatePlaceEntity createPlaceEntity}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.createStoryLocation,
      jsonBody: createPlaceEntity.toJson(),
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<PlaceModel> getUserPlaceById({required String placeId}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getStoryPlaceById,
      jsonBody: {"place_id": placeId},
    );
    if (res["success"] == true) {
      return PlaceModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<UserPlacesResultModel> getUserPlaces({required int page, required int perPage}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getStoryPlaces,
      jsonBody: {"page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return UserPlacesResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<UserPlacesResultModel> searchPlaces({required String search, required int page, required int perPage}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchStoryPlaces,
      jsonBody: {"search": search, "page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return UserPlacesResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> updateUserPlace({required CreatePlaceEntity createPlaceEntity}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.updateUserLocation,
      jsonBody: createPlaceEntity.toJson(),
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> deleteUserPlace({required int placeId}) {
    // TODO: implement deleteUserPlace
    throw UnimplementedError();
  }

  @override
  Future<AudioResultModel> getStoryAudios({required int page, required int perPage}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getStoryAudios,
      jsonBody: {"page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return AudioResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<AudioResultModel> searchStoryAudio({required int page, required int perPage, required String search}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchStoryAudio,
      jsonBody: {"page": page, "per_page": perPage,"search":search},
    );
    if (res["success"] == true) {
      return AudioResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }
}
