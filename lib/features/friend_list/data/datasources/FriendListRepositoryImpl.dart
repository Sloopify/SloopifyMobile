import 'package:sloopify_mobile/features/friend_list/data/datasources/friend_list_remote_data_source.dart';
import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';
import 'package:sloopify_mobile/features/friend_list/domain/repository/friend_list_repository.dart';

class FriendListRepositoryImpl implements FriendListRepository {
  final FriendRemoteDataSource remoteDataSource;

  FriendListRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Friend>> getSentFriendRequest({
    required int page,
    required int perPage,
    required String token,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
    final models = await remoteDataSource.getSentFriendRequests(
      page: page,
      perPage: perPage,
      sortBy: sortBy,
      sortOrder: sortOrder,
      status: status,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> cancelFriendRequest(String token, String friendId) {
    return remoteDataSource.cancelFriendRequest(friendId: friendId);
  }

  @override
  Future<void> sendFriendRequest(String token, String friendId) {
    return remoteDataSource.sendFriendRequest(friendId: friendId);
  }

  @override
  Future<void> acceptFriendRequest(String token, String friendshipId) {
    return remoteDataSource.acceptFriendRequest(friendshipId: friendshipId);
  }

  @override
  Future<void> declineFriendRequest(String token, String friendshipId) {
    return remoteDataSource.declineFriendRequest(friendshipId: friendshipId);
  }

  @override
  Future<List<Friend>> searchSentFriendRequests({
    required String token,
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
    final models = await remoteDataSource.searchSentFriendRequests(
      query: query,
      page: page,
      perPage: perPage,
      sortBy: sortBy,
      sortOrder: sortOrder,
      status: status,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Friend>> getReceivedFriendRequests({
    required int page,
    required int perPage,
    required String token,
    required String sortBy,
    required String sortOrder,
    required String status,
  }) async {
    final models = await remoteDataSource.getReceivedFriendRequests(
      page: page,
      perPage: perPage,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  @override
  Future<List<Friend>> searchReceivedFriendRequests({
    required String token,
    required String query,
    required int page,
    required int perPage,
    required String sortBy,
    required String sortOrder,
    required String status, // ✅ Add this
  }) async {
    final models = await remoteDataSource.searchReceivedFriendRequests(
      token: token,
      query: query,
      page: page,
      perPage: perPage,
      sortBy: sortBy,
      sortOrder: sortOrder,
      status: status, // ✅ Forward to remote
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Friend>> getFriendList(
    int page,
    int perPage,
    String token,
  ) async {
    final models = await remoteDataSource.getFriends(
      page: page,
      perPage: perPage,
      sortBy: 'default', // or pass these as parameters if needed
      sortOrder: 'asc',
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Friend>> searchFriends(
    String query,
    int page,
    int perPage,
    String token,
  ) async {
    final models = await remoteDataSource.searchFriends(
      query: query,
      page: page,
      perPage: perPage,
      sortBy: 'default',
      sortOrder: 'asc',
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> deleteFriendship(String token, String friendId) {
    return remoteDataSource.deleteFriendship(friendId: friendId);
  }

  @override
  Future<void> blockFriend(String token, String friendId) {
    return remoteDataSource.blockFriend(friendId: friendId);
  }
}
