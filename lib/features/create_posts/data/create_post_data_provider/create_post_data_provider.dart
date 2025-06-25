import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/data/models/user_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/activity_model.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/activity_result_model.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/feeling_model.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/feelings_result_model.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/friends_result_model.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/place_model.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/user_places_result_model.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/categories_activity_entity.dart';

import '../../../../core/api_service/api_urls.dart';
import '../../../../core/api_service/base_api_service.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/create_place_entity.dart';
import '../../domain/entities/regular_post_entity.dart';
import '../models/categories_activitiy_result_model.dart';

abstract class CreatePostDataProvider {
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

  Future<CategoriesActivityResultModel> getActivityCategories({
    required int page,
    required int perPage,
  });

  Future<ActivityResultModel> searchActivities({
    required String name,
    required int page,
    required int perPage,
  });

  Future<ActivityResultModel> getActivitiesByCategoryName({
    required String categoryName,
    required int page,
    required int perPage,
  });

  Future<CategoriesActivityResultModel> searchActivitiesCategoriesByName({
    required String name,
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

  Future<Unit> createPost({required RegularPostEntity regularPostEntity});
}

class CreatePosDataProviderImpl extends CreatePostDataProvider {
  final BaseApiService client;

  CreatePosDataProviderImpl({required this.client});

  @override
  Future<ActivityResultModel> getActivitiesByCategoryName({
    required String categoryName,
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getActivityByCategoryName,
      jsonBody: {"category": categoryName,"page":page,"per_page":perPage},
    );
    if (res["success"] == true) {
      return ActivityResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<CategoriesActivityResultModel> getActivityCategories({
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getCategoriesActivities,
      jsonBody: {"page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return CategoriesActivityResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<FriendsResultModel> getFriendsList({
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getFriends,
      jsonBody: {"page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return FriendsResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<ActivityResultModel> searchActivities({required String name,required int page,required int perPage}) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchActivityByName,
      jsonBody: {"search": name,"page":page,"per_page":perPage},
    );
    if (res["success"] == true) {
      return ActivityResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<CategoriesActivityResultModel> searchActivitiesCategoriesByName({
    required String name,
    required int page,
    required int perPage
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getCategoriesActivities,
      jsonBody: {"search": name,"page":page,"per_page":perPage},
    );
    if (res["success"] == true) {
      return CategoriesActivityResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<FeelingsResultModel> searchFeeling({
    required String feelingName,
    required int page,
    required int perPage
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchFeelingName,
      jsonBody: {"search": feelingName,"page":page,"per_page":perPage},
    );
    if (res["success"] == true) {
      return FeelingsResultModel.fromJson(res["data"]);
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
      url: ApiUrls.searchFriends,
      jsonBody: {"search": friendName, "page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return FriendsResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<FeelingsResultModel> getFeelings({required int page,required int perPage}) async {
    final res = await client.multipartRequest(url: ApiUrls.getFeelings,jsonBody: {"page":page,"per_page":perPage});
    if (res["success"] == true) {
      return FeelingsResultModel.fromJson(res["data"]);
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
  Future<UserPlacesResultModel> getUserPlaces({
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.getPlaces,
      jsonBody: {"page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return UserPlacesResultModel.fromJson(res["data"]);
    } else {
      throw NetworkErrorFailure(message: res['message']);
    }
  }

  @override
  Future<UserPlacesResultModel> searchPlaces({
    required String search,
    required int page,
    required int perPage,
  }) async {
    final res = await client.multipartRequest(
      url: ApiUrls.searchPlaces,
      jsonBody: {"search": search, "page": page, "per_page": perPage},
    );
    if (res["success"] == true) {
      return UserPlacesResultModel.fromJson(res["data"]);
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
      isContainsMedia:
          regularPostEntity.mediaFiles != null &&
                  regularPostEntity.mediaFiles!.isNotEmpty
              ? true
              : false,
    );
    if (res["success"] == true) {
      return unit;
    } else {
      String errorMessage = '';
      final errors = res['errors'] ?? res["message"];
      if (errors is String) {
        errorMessage = errors;
      } else if (errors is Map<String, dynamic>) {
        List<String> keys = (errors).keys.toList();
        keys.forEach((e) {
          if ((errors[e] as List<dynamic>).isNotEmpty) {
            errorMessage += errors[e].first + '\n';
          }
        });
      }
      throw NetworkErrorFailure(message: errorMessage);
    }
  }
}
