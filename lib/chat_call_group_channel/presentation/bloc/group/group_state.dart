import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';

class GroupState extends Equatable {
  final List<Friend> allFriends;
  final List<Friend> filteredFriends;
  final List<Friend> selectedFriends;
  final String searchQuery;
  final bool isAscending;
  final bool isLoading;

  const GroupState({
    this.allFriends = const [],
    this.filteredFriends = const [],
    this.selectedFriends = const [],
    this.searchQuery = '',
    this.isAscending = true,
    this.isLoading = false,
  });

  GroupState copyWith({
    List<Friend>? allFriends,
    List<Friend>? filteredFriends,
    List<Friend>? selectedFriends,
    String? searchQuery,
    bool? isAscending,
    bool? isLoading,
  }) {
    return GroupState(
      allFriends: allFriends ?? this.allFriends,
      filteredFriends: filteredFriends ?? this.filteredFriends,
      selectedFriends: selectedFriends ?? this.selectedFriends,
      searchQuery: searchQuery ?? this.searchQuery,
      isAscending: isAscending ?? this.isAscending,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    allFriends,
    filteredFriends,
    selectedFriends,
    searchQuery,
    isAscending,
    isLoading,
  ];
}
