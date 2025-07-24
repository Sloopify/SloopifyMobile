import 'package:flutter_bloc/flutter_bloc.dart';
import 'group_permission_event.dart';
import 'group_permission_state.dart';

class GroupPermissionBloc
    extends Bloc<GroupPermissionEvent, GroupPermissionState> {
  GroupPermissionBloc() : super(const GroupPermissionState()) {
    on<ToggleEditSettingsPermission>((event, emit) {
      emit(state.copyWith(canEditSettings: !state.canEditSettings));
    });

    on<ToggleSendMessagesPermission>((event, emit) {
      emit(state.copyWith(canSendMessages: !state.canSendMessages));
    });

    on<ToggleAddMembersPermission>((event, emit) {
      emit(state.copyWith(canAddMembers: !state.canAddMembers));
    });
  }
}
