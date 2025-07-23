import '../entities/friend.dart';

abstract class FriendListRepository {
  Future<List<Friend>> getFriendList(int page, int perPage, String token);
  Future<List<Friend>> searchFriends(
    String query,
    int page,
    int perPage,
    String token,
  );
  Future<List<Friend>> getSentFriendRequest({
    required int page,
    required int perPage,
    required String token,
    required String sortBy,
    required String sortOrder,
    required String status,
  });

  Future<void> cancelFriendRequest(String token, String friendId);
  Future<void> sendFriendRequest(String token, String friendId);
  Future<void> acceptFriendRequest(String token, String friendshipId);
  Future<List<Friend>> getReceivedFriendRequests({
    required int page,
    required int perPage,
    required String token,
    required String sortBy,
    required String sortOrder,
  });

  Future<void> declineFriendRequest(String token, String friendshipId);

  Future<void> deleteFriendship(String token, String friendId);
  Future<void> blockFriend(String token, String friendId);
}
