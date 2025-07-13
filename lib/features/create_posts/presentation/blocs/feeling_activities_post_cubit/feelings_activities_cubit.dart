import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/get_activities_by_categories_name.dart';
import '../../../domain/use_cases/get_categories_activities.dart';
import '../../../domain/use_cases/get_feelings_use_case.dart';
import '../../../domain/use_cases/search_activities_by_name_use_case.dart';
import '../../../domain/use_cases/search_categories_activiries_by_name.dart';
import '../../../domain/use_cases/search_feelings_use_case.dart';

part 'feelings_activities_state.dart';

class FeelingsActivitiesCubit extends Cubit<FeelingsActivitiesState> {
  final GetActivitiesByCategoriesName getActivitiesByCategoriesName;
  final GetCategoriesActivities getCategoriesActivities;
  final GetFeelingsUseCase getFeelingsUseCase;
  final SearchActivitiesByNameUseCase searchActivitiesByNameUseCase;
  final SearchCategoriesActivitiesByName searchCategoriesActivitiesByName;
  final SearchFeelingsUseCase searchFeelingsUseCase;

  FeelingsActivitiesCubit({
    required this.getActivitiesByCategoriesName,
    required this.getCategoriesActivities,
    required this.getFeelingsUseCase,
    required this.searchActivitiesByNameUseCase,
    required this.searchCategoriesActivitiesByName,
    required this.searchFeelingsUseCase,
  }) : super(FeelingsActivitiesState());
  final RefreshController feelingRefreshController = RefreshController();
  final RefreshController categoriesRefreshController = RefreshController();
  final RefreshController activitiesRefreshController = RefreshController();

  setSearchCategoryName(String value) {
    emit(
      state.copyWith(
        searchCategoryName: value,
        getCategoriesActivityStatus: GetCategoriesActivityStatus.init,
      ),
    );
  }

  setSearchActivityName(String value) {
    emit(
      state.copyWith(
        searchActivityName: value,
        getActivityStatus: GetActivityStatus.init,
      ),
    );
  }

  setFeelingName(String value) {
    emit(
      state.copyWith(
        searchFeelingName: value,
        getFeelingStatus: GetFeelingStatus.init,
      ),
    );
  }

  selectFeelings(String value) {
    emit(
      state.copyWith(
        selectedFeeling: value,
        getFeelingStatus: GetFeelingStatus.init,
      ),
    );
  }

  selectCategoryName(String value) {
    emit(
      state.copyWith(
        selectedCategoryName: value,
        getFeelingStatus: GetFeelingStatus.init,
      ),
    );
  }

  selectActivityName(String value) {
    emit(
      state.copyWith(
        selectedActivity: value,
        getFeelingStatus: GetFeelingStatus.init,
      ),
    );
  }

  getFeelings({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          feelingsPage: 1,
          hasFeelingsReachedEnd: false,
          allFeelings: [],
          getFeelingStatus: GetFeelingStatus.loading,
        ),
      );
    }
    final res = await getFeelingsUseCase.call(
      page: state.feelingsPage,
      perPage: 10,
    );
    res.fold(
      (l) {
        feelingRefreshController.loadFailed();
        _mapFailureGetFeelingsToState(emit, l, state);
      },
      (r) {
        final newList = [...state.allFeelings, ...r.feelings];
        emit(
          state.copyWith(
            allFeelings: newList,
            feelingsPage: state.feelingsPage + 1,
            hasFeelingsReachedEnd: !r.paginationData.hasMorePages,
            getFeelingStatus: GetFeelingStatus.success,
          ),
        );

        if (r.paginationData.hasMorePages) {
          feelingRefreshController.loadComplete();
        } else {
          feelingRefreshController.loadNoData();
        }
      },
    );
  }

  searchFeelings({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          feelingsPage: 1,
          hasFeelingsReachedEnd: false,
          allFeelings: [],
          getFeelingStatus: GetFeelingStatus.loading,
        ),
      );
    }
    final res = await searchFeelingsUseCase.call(
      name: state.searchFeelingName,
      perPage: 10,
      page: state.feelingsPage,
    );
    res.fold(
      (l) {
        feelingRefreshController.loadFailed();
        _mapFailureGetFeelingsToState(emit, l, state);
      },
      (r) {
        final newList = [...state.allFeelings, ...r.feelings];
        emit(
          state.copyWith(
            allFeelings: newList,
            feelingsPage: state.feelingsPage + 1,
            hasFeelingsReachedEnd: !r.paginationData.hasMorePages,
            getFeelingStatus: GetFeelingStatus.success,
          ),
        );

        if (r.paginationData.hasMorePages) {
          feelingRefreshController.loadComplete();
        } else {
          feelingRefreshController.loadNoData();
        }
      },
    );
  }

  void onLoadMoreFeelings() {
    if (!state.hasFeelingsReachedEnd) {
      state.searchFeelingName.isEmpty
          ? getFeelings(isLoadMore: true)
          : searchFeelings(isLoadMore: true);
    } else {
      feelingRefreshController.loadNoData();
    }
  }

  void onRefreshFeelings() async {
    emit(
      state.copyWith(
        feelingsPage: 1,
        allFeelings: [],
        hasFeelingsReachedEnd: false,
      ),
    );
    state.searchFeelingName.isEmpty ? getFeelings() : searchFeelings();
    feelingRefreshController.refreshCompleted();
  }

  getAllCategoriesActivities({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          categoriesPage: 1,
          hasCategoriesReachedEnd: false,
          categoriesActivity: [],
          getCategoriesActivityStatus: GetCategoriesActivityStatus.loading,
          getFeelingStatus: GetFeelingStatus.init,
        ),
      );
    }

    final res = await getCategoriesActivities.call(
      page: state.categoriesPage,
      perPage: 10,
    );
    res.fold(
      (l) {
        categoriesRefreshController.loadFailed();
        _mapFailureGetCategoriesActivitiesToState(emit, l, state);
      },
      (r) {
        final newList = [...state.categoriesActivity, ...r.categories];
        emit(
          state.copyWith(
            categoriesActivity: newList,
            categoriesPage: state.categoriesPage + 1,
            hasCategoriesReachedEnd: !r.paginationData.hasMorePages,
            getCategoriesActivityStatus: GetCategoriesActivityStatus.success,
          ),
        );

        if (r.paginationData.hasMorePages) {
          categoriesRefreshController.loadComplete();
        } else {
          categoriesRefreshController.loadNoData();
        }
      },
    );
  }

  searchCategoriesActivitiesByNameCategory({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          categoriesPage: 1,
          hasCategoriesReachedEnd: false,
          categoriesActivity: [],
          getCategoriesActivityStatus: GetCategoriesActivityStatus.loading,
          getFeelingStatus: GetFeelingStatus.init,
        ),
      );
    }
    final res = await searchCategoriesActivitiesByName.call(
      page: state.categoriesPage,
      perPage: 10,
      name: state.searchCategoryName,
    );
    res.fold(
      (l) {
        categoriesRefreshController.loadFailed();
        _mapFailureGetCategoriesActivitiesToState(emit, l, state);
      },
      (r) {
        final newList = [...state.categoriesActivity, ...r.categories];
        emit(
          state.copyWith(
            categoriesActivity: newList,
            categoriesPage: state.categoriesPage + 1,
            hasCategoriesReachedEnd: !r.paginationData.hasMorePages,
            getCategoriesActivityStatus: GetCategoriesActivityStatus.success,
          ),
        );

        if (r.paginationData.hasMorePages) {
          categoriesRefreshController.loadComplete();
        } else {
          categoriesRefreshController.loadNoData();
        }
      },
    );
  }

  void onLoadMoreCategories() {
    if (!state.hasCategoriesReachedEnd) {
      state.searchCategoryName.isEmpty
          ? getAllCategoriesActivities(isLoadMore: true)
          : searchCategoriesActivitiesByNameCategory(isLoadMore: true);
    } else {
      categoriesRefreshController.loadNoData();
    }
  }

  void onRefreshCategories() async {
    emit(
      state.copyWith(
        categoriesPage: 1,
        categoriesActivity: [],
        hasCategoriesReachedEnd: false,
      ),
    );
    state.searchCategoryName.isEmpty
        ? getAllCategoriesActivities()
        : searchCategoriesActivitiesByNameCategory();
    categoriesRefreshController.refreshCompleted();
  }

  getActivityByCategoryName({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          activitiesPage: 1,
          hasActivitiesReachedEnd: false,
          activities: [],
          getActivityStatus: GetActivityStatus.loading,
          getFeelingStatus: GetFeelingStatus.init,
          getCategoriesActivityStatus: GetCategoriesActivityStatus.init,
        ),
      );
    }
    final res = await getActivitiesByCategoriesName.call(
      perPage: 10,
      page: state.activitiesPage,
      categoryName: state.selectedCategoryName,
    );
    res.fold(
      (l) {
        _mapFailureGetActivitiesToState(emit, l, state);
        activitiesRefreshController.loadFailed();
      },
      (r) {
        final newList = [...state.activities, ...r.activities];
        emit(
          state.copyWith(
            activities: newList,
            activitiesPage: state.activitiesPage + 1,
            hasActivitiesReachedEnd: !r.paginationData.hasMorePages,
            getActivityStatus: GetActivityStatus.success,
          ),
        );

        if (r.paginationData.hasMorePages) {
          activitiesRefreshController.loadComplete();
        } else {
          activitiesRefreshController.loadNoData();
        }
      },
    );
  }

  searchActivityByCategoryName({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          activitiesPage: 1,
          hasActivitiesReachedEnd: false,
          activities: [],
          getActivityStatus: GetActivityStatus.loading,
          getFeelingStatus: GetFeelingStatus.init,
          getCategoriesActivityStatus: GetCategoriesActivityStatus.init,
        ),
      );
    }
    final res = await searchActivitiesByNameUseCase.call(
      page: state.activitiesPage,
      perPage: 10,
      name: state.searchActivityName,
    );
    res.fold(
      (l) {
        activitiesRefreshController.loadFailed();
        _mapFailureGetActivitiesToState(emit, l, state);
      },
      (r) {
        final newList = [...state.activities, ...r.activities];
        emit(
          state.copyWith(
            activities: newList,
            activitiesPage: state.activitiesPage + 1,
            hasActivitiesReachedEnd: !r.paginationData.hasMorePages,
            getActivityStatus: GetActivityStatus.success,
          ),
        );

        if (r.paginationData.hasMorePages) {
          activitiesRefreshController.loadComplete();
        } else {
          activitiesRefreshController.loadNoData();
        }

      },
    );
  }
  void onLoadMoreActivities() {
    if (!state.hasActivitiesReachedEnd) {
      state.searchActivityName.isEmpty
          ? getActivityByCategoryName(isLoadMore: true)
          : searchActivityByCategoryName(isLoadMore: true);
    } else {
      activitiesRefreshController.loadNoData();
    }
  }

  void onRefreshActivities() async {
    emit(
      state.copyWith(
        activitiesPage: 1,
        activities: [],
        hasActivitiesReachedEnd: false,
      ),
    );
    state.searchActivityName.isEmpty
        ? getActivityByCategoryName()
        : searchActivityByCategoryName();
    activitiesRefreshController.refreshCompleted();
  }

  _mapFailureGetFeelingsToState(
    emit,
    Failure f,
    FeelingsActivitiesState state,
  ) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            getFeelingStatus: GetFeelingStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            getFeelingStatus: GetFeelingStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

  _mapFailureGetCategoriesActivitiesToState(
    emit,
    Failure f,
    FeelingsActivitiesState state,
  ) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            getCategoriesActivityStatus: GetCategoriesActivityStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            getCategoriesActivityStatus: GetCategoriesActivityStatus.offline,
            errorMessage: f.message,
          ),
        );
    }
  }

  _mapFailureGetActivitiesToState(
    emit,
    Failure f,
    FeelingsActivitiesState state,
  ) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            getActivityStatus: GetActivityStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            getActivityStatus: GetActivityStatus.offline,
            errorMessage: f.message,
          ),
        );
    }
  }
}
