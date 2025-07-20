import 'package:equatable/equatable.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

class LoadGroupDetails extends GroupEvent {
  final String groupId;

  const LoadGroupDetails(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

class ToggleMemberSearch extends GroupEvent {}

class LeaveGroup extends GroupEvent {}

class ReportGroup extends GroupEvent {}

class AddNewMember extends GroupEvent {
  final String memberId;

  const AddNewMember(this.memberId);

  @override
  List<Object?> get props => [memberId];
}
