// data/datasources/friend_remote_data_source.dart
import 'package:dio/dio.dart';
import '../model/friend_model.dart';

abstract class FriendRemoteDataSource {
  Future<List<FriendModel>> getSentFriendRequests({
    required String token,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  });

  Future<void> cancelFriendRequest({
    required String token,
    required String friendId,
  });

  Future<void> sendFriendRequest({
    required String token,
    required String friendId,
  });

  Future<void> acceptFriendRequest({
    required String token,
    required String friendshipId,
  });

  Future<void> declineFriendRequest({
    required String token,
    required String friendshipId,
  });
  Future<List<FriendModel>> searchSentFriendRequests({
    required String token,
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  });

  Future<List<FriendModel>> getReceivedFriendRequests({
    required String token,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
  });

  Future<List<FriendModel>> searchReceivedFriendRequests({
    required String token,
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
  });

  Future<List<FriendModel>> getFriends({
    required String token,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
  });

  Future<List<FriendModel>> searchFriends({
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String token,
  });

  Future<void> deleteFriendship({
    required String token,
    required String friendId,
  });

  Future<void> blockFriend({required String token, required String friendId});
}
