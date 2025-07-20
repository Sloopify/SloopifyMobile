import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class LoadFriends extends GroupEvent {}

class SearchFriend extends GroupEvent {
  final String query;

  const SearchFriend(this.query);

  @override
  List<Object> get props => [query];
}

class ToggleFriendSelection extends GroupEvent {
  final Friend friend;

  const ToggleFriendSelection(this.friend);

  @override
  List<Object> get props => [friend];
}

class SortFriends extends GroupEvent {
  final bool ascending;

  const SortFriends(this.ascending);

  @override
  List<Object> get props => [ascending];
}

class RemoveSelectedFriend extends GroupEvent {
  final Friend friend;

  const RemoveSelectedFriend(this.friend);

  @override
  List<Object> get props => [friend];
}
