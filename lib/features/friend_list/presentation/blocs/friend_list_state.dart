import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';

abstract class FriendListState extends Equatable {
  @override
  List<Object> get props => [];
}

class FriendListInitial extends FriendListState {}

class FriendListLoading extends FriendListState {}

class FriendListLoaded extends FriendListState {
  final List<Friend> friends;

  FriendListLoaded(this.friends);

  @override
  List<Object> get props => [friends];
}

class FriendListError extends FriendListState {}
