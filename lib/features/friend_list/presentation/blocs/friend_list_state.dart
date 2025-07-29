import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';

abstract class FriendState {}

class FriendInitial extends FriendState {}

class FriendLoading extends FriendState {}

class FriendLoaded extends FriendState {
  final List<Friend> friends;
  final bool isLoadingMore;
  final bool hasMore;
  final int currentPage;
  final int perPage;
  FriendLoaded({
    required this.friends,
    required this.isLoadingMore,
    required this.hasMore,
    required this.currentPage,
    required this.perPage,
  });

  FriendLoaded copyWith({
    List<Friend>? friends,
    bool? isLoadingMore,
    bool? hasMore,
    int? currentPage,
    int? perPage,
  }) {
    return FriendLoaded(
      friends: friends ?? this.friends,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      perPage: perPage ?? this.perPage,
    );
  }

  List<Object?> get props => [
    friends,
    isLoadingMore,
    hasMore,
    currentPage,
    perPage,
  ];
}

class FriendError extends FriendState {
  final String message;

  FriendError(this.message);
}

class SearchLoading extends FriendState {}

class SearchLoaded extends FriendState {
  final List<Friend> results;
  SearchLoaded(this.results);
}

class SearchError extends FriendState {
  final String message;
  SearchError(this.message);
}

class SentFriendRequestLoaded extends FriendState {
  final List<Friend> sentRequests;

  SentFriendRequestLoaded(this.sentRequests);
}

class FriendActionSuccess extends FriendState {
  final String message;
  FriendActionSuccess(this.message);
}

class ReceivedFriendRequestLoading extends FriendState {}

class ReceivedFriendRequestLoaded extends FriendState {
  final List<Friend> requests;

  ReceivedFriendRequestLoaded(this.requests);
}

class ReceivedFriendRequestError extends FriendState {
  final String message;

  ReceivedFriendRequestError(this.message);
}

class DeclineFriendRequestSuccess extends FriendState {}

class DeclineFriendRequestError extends FriendState {
  final String message;

  DeclineFriendRequestError(this.message);
}

class BlockFriendSuccess extends FriendState {}

class DeleteFriendshipSuccess extends FriendState {}
