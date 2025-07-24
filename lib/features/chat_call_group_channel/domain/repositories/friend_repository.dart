import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';

abstract class FriendRepository {
  Future<List<Friend>> getAllFriends();
}
