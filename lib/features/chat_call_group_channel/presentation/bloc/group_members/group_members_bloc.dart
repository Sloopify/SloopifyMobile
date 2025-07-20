import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/member.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group_members/group_members_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group_members/group_members_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(const GroupState()) {
    on<LoadGroupDetails>(_onLoadGroupDetails);
    on<ToggleMemberSearch>(_onToggleSearch);
    on<LeaveGroup>(_onLeaveGroup);
    on<ReportGroup>(_onReportGroup);
    on<AddNewMember>(_onAddNewMember);
  }

  void _onLoadGroupDetails(LoadGroupDetails event, Emitter<GroupState> emit) {
    // Simulated data
    final dummyMembers = List.generate(
      5,
      (i) => Member(name: 'Member $i', imageUrl: '', isAdmin: i == 0),
    );

    emit(
      state.copyWith(
        groupName: 'Group name',
        groupDesc: 'Group description will be appear here',
        members: dummyMembers,
        isAdmin: true,
      ),
    );
  }

  void _onToggleSearch(ToggleMemberSearch event, Emitter<GroupState> emit) {
    emit(state.copyWith(isSearching: !state.isSearching));
  }

  void _onLeaveGroup(LeaveGroup event, Emitter<GroupState> emit) {
    // Leave logic
  }

  void _onReportGroup(ReportGroup event, Emitter<GroupState> emit) {
    // Report logic
  }

  void _onAddNewMember(AddNewMember event, Emitter<GroupState> emit) {
    // Add member logic
  }
}
