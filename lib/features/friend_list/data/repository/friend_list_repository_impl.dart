import 'package:dio/dio.dart';
import 'package:sloopify_mobile/features/friend_list/data/datasources/friend_list_remote_data_source.dart';
import 'package:sloopify_mobile/features/friend_list/data/model/friend_model.dart';

class FriendRemoteDataSourceImpl implements FriendRemoteDataSource {
  final Dio dio;

  FriendRemoteDataSourceImpl(this.dio);

  @override
  Future<List<FriendModel>> getFriendList({
    required int page,
    required int perPage,
    required String token,
  }) async {
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
    required String token,
  }) async {
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
    required String token,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
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
  Future<void> cancelFriendRequest({
    required String token,
    required String friendId,
  }) async {
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
  Future<void> sendFriendRequest({
    required String token,
    required String friendId,
  }) async {
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
  Future<void> acceptFriendRequest({
    required String token,
    required String friendshipId,
  }) async {
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
    required String token,
    required String sortBy,
    required String sortOrder,
  }) async {
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
  Future<void> declineFriendRequest({
    required String token,
    required String friendshipId,
  }) async {
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
    required String token,
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
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
  }) async {
    final response = await dio.post(
      'https://dev.sloopify.com/api/v1/friends/search-received-requests',
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
  Future<void> deleteFriendship({
    required String token,
    required String friendId,
  }) async {
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
  Future<void> blockFriend({
    required String token,
    required String friendId,
  }) async {
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
    required String token,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
  }) async {
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
    required String token,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
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
