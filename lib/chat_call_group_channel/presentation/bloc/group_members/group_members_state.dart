import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/member.dart';

class GroupState extends Equatable {
  final bool isAdmin;
  final List<Member> members;
  final bool isSearching;
  final String groupName;
  final String groupDesc;

  const GroupState({
    this.isAdmin = false,
    this.members = const [],
    this.isSearching = false,
    this.groupName = '',
    this.groupDesc = '',
  });

  GroupState copyWith({
    bool? isAdmin,
    List<Member>? members,
    bool? isSearching,
    String? groupName,
    String? groupDesc,
  }) {
    return GroupState(
      isAdmin: isAdmin ?? this.isAdmin,
      members: members ?? this.members,
      isSearching: isSearching ?? this.isSearching,
      groupName: groupName ?? this.groupName,
      groupDesc: groupDesc ?? this.groupDesc,
    );
  }

  @override
  List<Object?> get props => [
    isAdmin,
    members,
    isSearching,
    groupName,
    groupDesc,
  ];
}
