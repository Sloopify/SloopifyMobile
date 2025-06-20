part of 'feelings_activities_cubit.dart';

enum GetFeelingStatus { init, loading, success, offline, error }

enum GetCategoriesActivityStatus { init, loading, success, offline, error }

enum GetActivityStatus { init, loading, success, offline, error }

class FeelingsActivitiesState extends Equatable {
  final List<FeelingEntity> allFeelings;
  final String selectedFeeling;
  final List<dynamic> categoriesActivity;
  final List<ActivityEntity> activities;
  final String selectedActivity;
  final GetFeelingStatus getFeelingStatus;
  final GetCategoriesActivityStatus getCategoriesActivityStatus;
  final GetActivityStatus getActivityStatus;
  final String searchFeelingName;
  final String searchCategoryName;
  final String searchActivityName;
  final String errorMessage;
  final String selectedCategoryName;

  const FeelingsActivitiesState({
    this.activities = const [],
    this.selectedCategoryName = "",
    this.allFeelings = const [],
    this.categoriesActivity = const [],
    this.selectedActivity = "",
    this.selectedFeeling = "",
    this.getCategoriesActivityStatus = GetCategoriesActivityStatus.init,
    this.getActivityStatus = GetActivityStatus.init,
    this.getFeelingStatus = GetFeelingStatus.init,
    this.searchFeelingName = "",
    this.searchActivityName = "",
    this.searchCategoryName = "",
    this.errorMessage = "",
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    activities,
    allFeelings,
    categoriesActivity,
    selectedActivity,
    selectedFeeling,
    getCategoriesActivityStatus,
    getActivityStatus,
    getFeelingStatus,
    searchCategoryName,
    searchActivityName,
    searchFeelingName,
    errorMessage,
    selectedCategoryName,
  ];

  FeelingsActivitiesState copyWith({
    List<FeelingEntity>? allFeelings,
    String? selectedFeeling,
    String? selectedCategoryName,
    List<dynamic>? categoriesActivity,
    List<ActivityEntity>? activities,
    String? selectedActivity,
    GetFeelingStatus? getFeelingStatus,
    GetCategoriesActivityStatus? getCategoriesActivityStatus,
    GetActivityStatus? getActivityStatus,
    String? searchFeelingName,
    String? searchCategoryName,
    String? searchActivityName,
    String? errorMessage,
  }) {
    return FeelingsActivitiesState(
      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,

      activities: activities ?? this.activities,
      allFeelings: allFeelings ?? this.allFeelings,
      categoriesActivity: categoriesActivity ?? this.categoriesActivity,
      getActivityStatus: getActivityStatus ?? this.getActivityStatus,
      getCategoriesActivityStatus:
          getCategoriesActivityStatus ?? this.getCategoriesActivityStatus,
      getFeelingStatus: getFeelingStatus ?? this.getFeelingStatus,
      selectedActivity: selectedActivity ?? this.selectedActivity,
      selectedFeeling: selectedFeeling ?? this.selectedFeeling,
      errorMessage: errorMessage ?? this.errorMessage,
      searchActivityName: searchActivityName ?? this.searchActivityName,
      searchCategoryName: searchCategoryName ?? this.searchCategoryName,
      searchFeelingName: searchFeelingName ?? this.searchFeelingName,
    );
  }
}
