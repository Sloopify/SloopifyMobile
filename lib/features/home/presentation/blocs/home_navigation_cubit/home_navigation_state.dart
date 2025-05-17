import 'package:equatable/equatable.dart';

class HomeNavigationState extends Equatable {
  final int selectedIndex;
  final bool isFabPanelOpen;

  HomeNavigationState({required this.selectedIndex, required this.isFabPanelOpen});

  HomeNavigationState copyWith({int? selectedIndex, bool? isFabPanelOpen}) {
    return HomeNavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isFabPanelOpen: isFabPanelOpen ?? this.isFabPanelOpen,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [selectedIndex,isFabPanelOpen];
}