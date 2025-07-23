abstract class FriendEvent {}

class LoadFriends extends FriendEvent {
  final int page;
  final int perPage;

  LoadFriends({required this.page, required this.perPage});
}

class SearchFriendsEvent extends FriendEvent {
  final String query;
  final int page;
  final int perPage;

  SearchFriendsEvent({
    required this.query,
    required this.page,
    required this.perPage,
  });
}

class LoadSentFriendRequests extends FriendEvent {
  final int page;
  final int perPage;

  final String sortBy;
  final String sortOrder;
  final String status;

  LoadSentFriendRequests({
    required this.page,
    required this.perPage,

    required this.sortBy,
    required this.sortOrder,
    required this.status,
  });
}

class CancelFriendRequestEvent extends FriendEvent {
  final String friendId;
  CancelFriendRequestEvent({required this.friendId});
}

class SendFriendRequestEvent extends FriendEvent {
  final String friendId;
  SendFriendRequestEvent({required this.friendId});
}

class AcceptFriendRequestEvent extends FriendEvent {
  final String friendshipId;
  AcceptFriendRequestEvent({required this.friendshipId});
}

class LoadReceivedFriendRequests extends FriendEvent {
  final int page;
  final int perPage;

  final String sortBy;
  final String sortOrder;

  LoadReceivedFriendRequests({
    required this.page,
    required this.perPage,

    required this.sortBy,
    required this.sortOrder,
  });
}

class DeclineFriendRequestEvent extends FriendEvent {
  final String friendshipId;

  DeclineFriendRequestEvent({required this.friendshipId});
}

class DeleteFriendshipEvent extends FriendEvent {
  final String friendId;

  DeleteFriendshipEvent({required this.friendId});
}

class BlockFriendEvent extends FriendEvent {
  final String friendId;

  BlockFriendEvent({required this.friendId});
}
