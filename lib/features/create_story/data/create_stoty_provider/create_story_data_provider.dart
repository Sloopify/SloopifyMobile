import '../../../../core/api_service/api_urls.dart';
import '../../../../core/api_service/base_api_service.dart';
import '../../../../core/errors/failures.dart';
import '../../../create_posts/data/models/feelings_result_model.dart';
import '../../../create_posts/data/models/friends_result_model.dart';

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
}
