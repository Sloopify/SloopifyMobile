import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/home/presentation/blocs/home_navigation_cubit/home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit()
    : super(HomeNavigationState(selectedIndex: 0, isFabPanelOpen: false));

  void navigateTo(int index) =>
      emit(state.copyWith(selectedIndex: index, isFabPanelOpen: false));

  void toggleFabPanel() =>
      emit(state.copyWith(isFabPanelOpen: !state.isFabPanelOpen));
}
