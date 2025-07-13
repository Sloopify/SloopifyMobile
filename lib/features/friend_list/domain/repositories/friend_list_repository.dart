import '../entities/friend.dart';

abstract class FriendListRepository {
  Future<List<Friend>> getFriendList();
}
