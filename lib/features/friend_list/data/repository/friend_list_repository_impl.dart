import 'package:dio/dio.dart';
import 'package:sloopify_mobile/core/local_storage/preferene_utils.dart';

import 'package:sloopify_mobile/features/friend_list/data/datasources/friend_list_remote_data_source.dart';
import 'package:sloopify_mobile/features/friend_list/data/model/friend_model.dart';

class FriendRemoteDataSourceImpl implements FriendRemoteDataSource {
  final Dio dio;
  String devToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODU3MjhjNmMxN2ZhYTRmN2UxMGI5MWUxYTA3MzNmMzhmODc2MjE0MzA2ZGNlNjgwODE1NDUzYWZmMWVkNWQyZmY5MTBiMTIyNWE4NmIxMDciLCJpYXQiOjE3NTM0NjA0MTAuNzY0NjYyLCJuYmYiOjE3NTM0NjA0MTAuNzY0NjY0LCJleHAiOjE3ODQ5OTY0MTAuNzU4Mzk4LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.C0SBy8a_oaldiX22-PClyzxiM3KhhgXRO66aW1CwIApc9azFCOMeXR3dfxOVXOHwW94kHPOkmFWrX3r-S2BQZJtHsAeUQ0l7-OZXaTiV-bEaaS1OFONsJOfXmYXETqWKPyejT0xmUQd_7atsgQw-uAqs86P1figO3W37vK2aOpp8sttcU4e_9Ysqp_jYl-kqxgpJHCiCxeDw8oPFLieda1ixE6cbKKHuu8OVFKcrzvw2POwJKrrsz33PUqqmfqd2YKHcKWGvDfR5mp3tMnoUIFP5GubCuJ8rntwuCV17hQi2Warh3PWMfJVErRtPjbkGwOtoWL6Rpld6GRyLl92DR93zHySlBwozs37INXpqpKHDARsqZNOO1XkM6sr4OMiv-T1ATnS_UkLYd2FLuO50XCwLevx3Fd5eozwl4J5JCeMiRcFeJxwPMWprpCd5vzMALTqGnC2txQGN_DvtaH5KeC9xKLs8K4-RY-ed7BrO7Zw4nCApC3jFTBPVT_wQNhORbungmuEE_LlaXCeyhKbv2q6iMJSCMLOqJQ_qfPbY2jJftrddcRmpxJDpSZ8RWXoKmOSIZpyLKwu9fFmiVzueqxrvIZwNbVPD0U7aiHixUVQWqCxGuQJD8PtyqrGPoXCjSPBcFeJs29azCbf33dSgx648nFT-Wjysu6L3Kmf473I";

  FriendRemoteDataSourceImpl({required this.dio});

  String _getToken() {
    final token = PreferenceUtils.getString("auth_token");
    if (token == null || token.isEmpty) {
      print("❌ No saved token. Using devToken.");
      return devToken;
    }
    print("✅ Got user token: $token");
    return token;
  }

  @override
  Future<List<FriendModel>> getFriendList({
    required int page,
    required int perPage,
  }) async {
    final token = await _getToken();
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/stories/get-friends',
      data: {"page": page, "per_page": perPage},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => FriendModel.fromJson(json)).toList();
  }

  @override
  Future<List<FriendModel>> searchFriends({
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
  }) async {
    final token = await _getToken();
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/friends/search-friends',
      data: {
        "search": query,
        "page": page,
        "per_page": perPage,
        "sort_by": sortBy,
        "sort_order": sortOrder,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => FriendModel.fromJson(json)).toList();
  }

  @override
  Future<List<FriendModel>> getSentFriendRequest({
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
    final token = await _getToken();
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/friends/get-sent-requests',
      data: {
        "page": page,
        "per_page": perPage,
        "sort_by": sortBy,
        "sort_order": sortOrder,
        "status": status,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => FriendModel.fromJson(json)).toList();
  }

  @override
  Future<void> cancelFriendRequest({required String friendId}) async {
    final token = await _getToken();
    await dio.post(
      'https://dev.sloopify.com/api/v1/friends/cancel-friend-request',
      data: {"friend_id": friendId},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<void> sendFriendRequest({required String friendId}) async {
    final token = await _getToken();
    await dio.post(
      'https://dev.sloopify.com/api/v1/friends/send-request',
      data: {"friend_id": friendId},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<void> acceptFriendRequest({required String friendshipId}) async {
    final token = await _getToken();
    await dio.post(
      'https://dev.sloopify.com/api/v1/friends/accept-friend-request',
      data: {"friendship_id": friendshipId},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<List<FriendModel>> getReceivedFriendRequests({
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
  }) async {
    final token = await _getToken();
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/friends/get-received-requests',
      data: {
        "page": page,
        "per_page": perPage,
        "sort_by": sortBy,
        "sort_order": sortOrder,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => FriendModel.fromJson(json)).toList();
  }

  @override
  Future<void> declineFriendRequest({required String friendshipId}) async {
    final token = await _getToken();
    await dio.post(
      'https://dev.sloopify.com/api/v1/friends/decline-friend-request',
      data: {"friendship_id": friendshipId},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<List<FriendModel>> searchSentFriendRequests({
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
    final token = await _getToken();
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/friends/search-sent-requests',
      data: {
        "search": query,
        "page": page,
        "per_page": perPage,
        "sort_by": sortBy,
        "sort_order": sortOrder,
        "status": status,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => FriendModel.fromJson(json)).toList();
  }

  @override
  Future<List<FriendModel>> searchReceivedFriendRequests({
    required String token,

    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
    final token = await _getToken();
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/friends/search-received-requests',
      data: {
        "search": query,
        "page": page,
        "per_page": perPage,
        "sort_by": sortBy,
        "sort_order": sortOrder,
        "status": status,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => FriendModel.fromJson(json)).toList();
  }

  @override
  Future<void> deleteFriendship({required String friendId}) async {
    final token = await _getToken();
    await dio.post(
      'https://dev.sloopify.com/api/v1/friends/delete-friend-ship',
      data: {"friend_id": friendId},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<void> blockFriend({required String friendId}) async {
    final token = await _getToken();
    await dio.post(
      'https://dev.sloopify.com/api/v1/friends/block-friend',
      data: {"friend_id": friendId},
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<List<FriendModel>> getFriends({
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
  }) async {
    final token = await _getToken();
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/friends/get-friends',
      data: {
        "page": page,
        "per_page": perPage,
        "sort_by": sortBy,
        "sort_order": sortOrder,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => FriendModel.fromJson(json)).toList();
  }

  @override
  Future<List<FriendModel>> getSentFriendRequests({
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
    final token = await _getToken();
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/friends/get-sent-requests',
      data: {
        "page": page,
        "per_page": perPage,
        "sort_by": sortBy,
        "sort_order": sortOrder,
        "status": status,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final List<dynamic> data = response.data['data'];
    return data.map((json) => FriendModel.fromJson(json)).toList();
  }
}
