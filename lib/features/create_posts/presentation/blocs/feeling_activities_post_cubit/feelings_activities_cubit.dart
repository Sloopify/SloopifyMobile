import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
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

  getFeelings() async {
    emit(state.copyWith(getFeelingStatus: GetFeelingStatus.loading));
    final res = await getFeelingsUseCase.call();
    res.fold(
      (l) {
        _mapFailureGetFeelingsToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getFeelingStatus: GetFeelingStatus.success,
            allFeelings: r,
          ),
        );
      },
    );
  }

  searchFeelings() async {
    emit(state.copyWith(getFeelingStatus: GetFeelingStatus.loading));
    final res = await searchFeelingsUseCase.call(name: state.searchFeelingName);
    res.fold(
      (l) {
        _mapFailureGetFeelingsToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getFeelingStatus: GetFeelingStatus.success,
            allFeelings: r,
          ),
        );
      },
    );
  }

  getAllCategoriesActivities() async {
    emit(
      state.copyWith(
        getFeelingStatus: GetFeelingStatus.init,
        getCategoriesActivityStatus: GetCategoriesActivityStatus.loading,
      ),
    );
    final res = await getCategoriesActivities.call();
    res.fold(
      (l) {
        _mapFailureGetCategoriesActivitiesToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getCategoriesActivityStatus: GetCategoriesActivityStatus.success,
            categoriesActivity: r,
          ),
        );
      },
    );
  }

  searchCategoriesActivitiesByNameCategory() async {
    emit(
      state.copyWith(
        getFeelingStatus: GetFeelingStatus.init,
        getCategoriesActivityStatus: GetCategoriesActivityStatus.loading,
      ),
    );
    final res = await searchCategoriesActivitiesByName.call(
      name: state.searchCategoryName,
    );
    res.fold(
      (l) {
        _mapFailureGetCategoriesActivitiesToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getCategoriesActivityStatus: GetCategoriesActivityStatus.success,
            categoriesActivity: r,
          ),
        );
      },
    );
  }

  getActivityByCategoryName() async {
    emit(
      state.copyWith(
        getFeelingStatus: GetFeelingStatus.init,
        getCategoriesActivityStatus: GetCategoriesActivityStatus.init,
        getActivityStatus: GetActivityStatus.loading,
      ),
    );
    final res = await getActivitiesByCategoriesName.call(
      categoryName: state.selectedCategoryName,
    );
    res.fold(
      (l) {
        _mapFailureGetActivitiesToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getActivityStatus: GetActivityStatus.success,
            activities: r,
          ),
        );
      },
    );
  }

  searchActivityByCategoryName() async {
    emit(
      state.copyWith(
        getFeelingStatus: GetFeelingStatus.init,
        getCategoriesActivityStatus: GetCategoriesActivityStatus.init,
        getActivityStatus: GetActivityStatus.loading,
      ),
    );
    final res = await searchActivitiesByNameUseCase.call(
      name: state.searchActivityName,
    );
    res.fold(
      (l) {
        _mapFailureGetActivitiesToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getActivityStatus: GetActivityStatus.success,
            activities: r,
          ),
        );
      },
    );
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
