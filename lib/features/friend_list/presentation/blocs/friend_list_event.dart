import 'package:equatable/equatable.dart';

abstract class FriendListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadFriendList extends FriendListEvent {}
