import '../model/friend_model.dart';

abstract class FriendRemoteDataSource {
  Future<List<FriendModel>> getSentFriendRequests({
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  });

  Future<void> cancelFriendRequest({required String friendId});

  Future<void> sendFriendRequest({required String friendId});

  Future<void> acceptFriendRequest({required String friendshipId});

  Future<void> declineFriendRequest({required String friendshipId});

  Future<List<FriendModel>> searchSentFriendRequests({
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  });

  Future<List<FriendModel>> getReceivedFriendRequests({
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
    required String status,
  });

  Future<List<FriendModel>> getFriends({
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
  });

  Future<void> deleteFriendship({required String friendId});

  Future<void> blockFriend({required String friendId});
}
