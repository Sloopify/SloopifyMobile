import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/data/models/user_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/activity_model.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/feeling_model.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/place_model.dart';

import '../../../../core/api_service/api_urls.dart';
import '../../../../core/api_service/base_api_service.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/create_place_entity.dart';
import '../../domain/entities/regular_post_entity.dart';

abstract class CreatePostDataProvider {
  Future<List<UserModel>> getFriendsList();

  Future<List<UserModel>> searchFriendsList({required String friendName});

  Future<List<FeelingModel>> searchFeeling({required String feelingName});

  Future<List<FeelingModel>> getFeelings();

  Future<List<dynamic>> getActivityCategories();

  Future<List<ActivityModel>> searchActivities({required String name});

  Future<List<ActivityModel>> getActivitiesByCategoryName({
    required String categoryName,
  });

  Future<List<dynamic>> searchActivitiesCategoriesByName({
    required String name,
  });

  Future<List<PlaceModel>> getUserPlaces();

  Future<PlaceModel> getUserPlaceById({required String placeId});

  Future<List<PlaceModel>> searchPlaces({required String search});

  Future<Unit> createPlace({required CreatePlaceEntity createPlaceEntity});

  Future<Unit> updateUserPlace({required CreatePlaceEntity createPlaceEntity});

  Future<Unit> createPost({required RegularPostEntity regularPostEntity});
}

class CreatePosDataProviderImpl extends CreatePostDataProvider {
  final BaseApiService client;

  CreatePosDataProviderImpl({required this.client});

  @override
  Future<List<ActivityModel>> getActivitiesByCategoryName({
    required String categoryName,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getActivityByCategoryName,
      jsonBody: {"category": categoryName},
    );
    if (res["success"] == true) {
      return List.generate(
        (res["data"] as List).length,
        (e) => ActivityModel.fromJson(res["data"][e]),
      );
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<dynamic>> getActivityCategories() async {
    final res = await client.getRequest(url: ApiUrls.getCategoriesActivities);
    if (res["success"] == true) {
      return res["data"];
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<UserModel>> getFriendsList() async {
    final res = await client.getRequest(url: ApiUrls.getFriends);
    if (res["success"] == true) {
      return List.generate(
        (res["data"] as List).length,
        (e) => UserModel.fromJson(res["data"][e]),
      );
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<ActivityModel>> searchActivities({required String name}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchActivityByName,
      jsonBody: {"search": name},
    );
    if (res["success"] == true) {
      return List.generate(
        (res["data"] as List).length,
        (e) => ActivityModel.fromJson(res["data"][e]),
      );
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<dynamic>> searchActivitiesCategoriesByName({
    required String name,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getCategoriesActivities,
      jsonBody: {"search": name},
    );
    if (res["success"] == true) {
      return res["data"];
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<FeelingModel>> searchFeeling({
    required String feelingName,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchFeelingName,
      jsonBody: {"search": feelingName},
    );
    if (res["success"] == true) {
      return List.generate(
        (res["data"] as List).length,
        (e) => FeelingModel.fromJson(res["data"][e]),
      );
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<UserModel>> searchFriendsList({
    required String friendName,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchFriends,
      jsonBody: {"search": friendName},
    );
    if (res["success"] == true) {
      return List.generate(
        (res["data"] as List).length,
        (e) => UserModel.fromJson(res["data"][e]),
      );
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<FeelingModel>> getFeelings() async {
    final res = await client.getRequest(url: ApiUrls.getFeelings);
    if (res["success"] == true) {
      return List.generate(
        (res["data"] as List).length,
        (e) => FeelingModel.fromJson(res["data"][e]),
      );
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> createPlace({
    required CreatePlaceEntity createPlaceEntity,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.createPlace,
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
      url: ApiUrls.getPlaceById,
      jsonBody: {"place_id": placeId},
    );
    if (res["success"] == true) {
      return PlaceModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<PlaceModel>> getUserPlaces() async {
    final res = await client.getRequest(url: ApiUrls.getPlaces);
    if (res["success"] == true) {
      return List.generate(
        (res["data"] as List).length,
        (e) => PlaceModel.fromJson(res["data"][e]),
      );
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<List<PlaceModel>> searchPlaces({required String search}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchPlaces,
      jsonBody: {"search": search},
    );
    if (res["success"] == true) {
      return List.generate(
        (res["data"] as List).length,
        (e) => PlaceModel.fromJson(res["data"][e]),
      );
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> updateUserPlace({
    required CreatePlaceEntity createPlaceEntity,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.updatePlace,
      jsonBody: createPlaceEntity.toJson(),
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<Unit> createPost({
    required RegularPostEntity regularPostEntity,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.createPost,
      jsonBody: await regularPostEntity.toJson(),
      isContainsMedia: regularPostEntity.mediaFiles!=null && regularPostEntity.mediaFiles!.isNotEmpty?true:false,
    );
    if (res["success"] == true) {
      return unit;
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }
}
