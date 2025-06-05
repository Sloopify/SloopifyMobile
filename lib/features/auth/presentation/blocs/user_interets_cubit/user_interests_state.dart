import 'package:sloopify_mobile/features/auth/domain/entities/user_intresets_entity.dart';

enum GetCategoriesStatus { loading, init, success, error, offline }

enum GetCategoriesInterestsStatus { loading, init, success, error, offline }

enum CompleteInterestsStatus { loading, init, success, error, offline }

class InterestState {
  final List<UserInterestsEntity> categoriesInterests;
  final List<dynamic> categoriesName;
  final Set<int> selectedInterestIds;
  final int currentCategoryIndex;
  final int page;
  final GetCategoriesStatus getCategoriesStatus;
  final GetCategoriesInterestsStatus getCategoriesInterestsStatus;
  final bool hasReachedEnd;
  final String errorMessage;
  final String currentCategoryName;
  final CompleteInterestsStatus completeInterestsStatus;

  InterestState({
    this.categoriesName = const [],
    this.currentCategoryName = "",
    this.categoriesInterests = const [],
    this.selectedInterestIds = const {},
    this.currentCategoryIndex = 0,
    this.page = 1,
    this.getCategoriesStatus = GetCategoriesStatus.init,
    this.completeInterestsStatus = CompleteInterestsStatus.init,
    this.hasReachedEnd = false,
    this.errorMessage = "",
    this.getCategoriesInterestsStatus = GetCategoriesInterestsStatus.init,
  });

  InterestState copyWith({
    List<UserInterestsEntity>? categoriesInterests,
    Set<int>? selectedInterestIds,
    int? currentCategoryIndex,
    int? page,
    GetCategoriesStatus? getCategoriesStatus,
    bool? hasReachedEnd,
    String? errorMessage,
    GetCategoriesInterestsStatus? getCategoriesInterestsStatus,
    List<dynamic>? categoriesName,
    String? selectedCategoryName,
    CompleteInterestsStatus? completeInterestsStatus,
  }) {
    return InterestState(
      completeInterestsStatus:
          completeInterestsStatus ?? this.completeInterestsStatus,
      currentCategoryName: selectedCategoryName ?? currentCategoryName,
      categoriesInterests: categoriesInterests ?? this.categoriesInterests,
      categoriesName: categoriesName ?? this.categoriesName,
      getCategoriesInterestsStatus:
          getCategoriesInterestsStatus ?? this.getCategoriesInterestsStatus,
      selectedInterestIds: selectedInterestIds ?? this.selectedInterestIds,
      currentCategoryIndex: currentCategoryIndex ?? this.currentCategoryIndex,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      getCategoriesStatus: getCategoriesStatus ?? this.getCategoriesStatus,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
