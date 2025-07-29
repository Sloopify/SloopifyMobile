import 'package:equatable/equatable.dart';

abstract class FriendEvent extends Equatable {
  const FriendEvent();

  @override
  List<Object?> get props => [];
}

class LoadFriends extends FriendEvent {
  final int page;
  final int perPage;

  const LoadFriends({required this.page, required this.perPage});

  @override
  List<Object?> get props => [page, perPage];
}

class LoadMoreFriends extends FriendEvent {
  const LoadMoreFriends();
}

class SearchFriendsEvent extends FriendEvent {
  final String query;
  final int page;
  final int perPage;

  const SearchFriendsEvent({
    required this.query,
    required this.page,
    required this.perPage,
  });

  @override
  List<Object?> get props => [query, page, perPage];
}

class LoadSentFriendRequests extends FriendEvent {
  final int page;
  final int perPage;
  final String sortBy;
  final String sortOrder;
  final String status;

  const LoadSentFriendRequests({
    required this.page,
    required this.perPage,
    required this.sortBy,
    required this.sortOrder,
    required this.status,
  });

  @override
  List<Object?> get props => [page, perPage, sortBy, sortOrder, status];
}

class CancelFriendRequestEvent extends FriendEvent {
  final String friendId;

  const CancelFriendRequestEvent({required this.friendId});

  @override
  List<Object?> get props => [friendId];
}

class SendFriendRequestEvent extends FriendEvent {
  final String friendId;

  const SendFriendRequestEvent({required this.friendId});

  @override
  List<Object?> get props => [friendId];
}

class AcceptFriendRequestEvent extends FriendEvent {
  final String friendshipId;

  const AcceptFriendRequestEvent({required this.friendshipId});

  @override
  List<Object?> get props => [friendshipId];
}

class LoadReceivedFriendRequests extends FriendEvent {
  final int page;
  final int perPage;
  final String sortBy;
  final String sortOrder;

  const LoadReceivedFriendRequests({
    required this.page,
    required this.perPage,
    required this.sortBy,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [page, perPage, sortBy, sortOrder];
}

class DeclineFriendRequestEvent extends FriendEvent {
  final String friendshipId;

  const DeclineFriendRequestEvent({required this.friendshipId});

  @override
  List<Object?> get props => [friendshipId];
}

class DeleteFriendshipEvent extends FriendEvent {
  final String friendId;

  const DeleteFriendshipEvent({required this.friendId});

  @override
  List<Object?> get props => [friendId];
}

class BlockFriendEvent extends FriendEvent {
  final String friendId;

  const BlockFriendEvent({required this.friendId});

  @override
  List<Object?> get props => [friendId];
}

class SearchReceivedFriendRequestsEvent extends FriendEvent {
  final String token;
  final String query;
  final int page;
  final int perPage;
  final String sortBy;
  final String sortOrder;
  final String status;

  const SearchReceivedFriendRequestsEvent({
    required this.token,
    required this.query,
    required this.page,
    required this.perPage,
    required this.sortBy,
    required this.sortOrder,
    required this.status,
  });

  @override
  List<Object?> get props => [
    token,
    query,
    page,
    perPage,
    sortBy,
    sortOrder,
    status,
  ];
}
