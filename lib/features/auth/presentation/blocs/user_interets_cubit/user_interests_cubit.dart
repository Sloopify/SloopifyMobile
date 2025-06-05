import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_interests_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/get_all_categories_use_case.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/user_interets_cubit/user_interests_state.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/get_user_interests_use_case.dart';

class InterestCubit extends Cubit<InterestState> {
  final GetUserInterestsUseCase getUserInterestsUseCase;
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final CompleteInterestsUseCase completeInterestsUseCase;

  InterestCubit({
    required this.getUserInterestsUseCase,
    required this.getAllCategoriesUseCase,
    required this.completeInterestsUseCase,
  }) : super(InterestState());
  final RefreshController refreshController = RefreshController();

  Future<void> getAllCategories() async {
    emit(state.copyWith(getCategoriesStatus: GetCategoriesStatus.loading));
    final res = await getAllCategoriesUseCase.call();
    res.fold(
      (l) {
        _mapFailureCategoriesToState(emit, l, state);
      },
      (r) {
        emit(
          state.copyWith(
            getCategoriesStatus: GetCategoriesStatus.success,
            categoriesName: r,
            selectedCategoryName: r.first,
          ),
        );
        if (state.categoriesName.isNotEmpty) {
          fetchCategoriesInterests();
        }
      },
    );
  }

  Future<void> fetchCategoriesInterests({bool isLoadMore = false}) async {
    if (state.getCategoriesInterestsStatus ==
        GetCategoriesInterestsStatus.loading)
      return;

    if (!isLoadMore) {
      emit(
        state.copyWith(
          categoriesInterests: [],
          page: 1,
          hasReachedEnd: false,
          getCategoriesInterestsStatus: GetCategoriesInterestsStatus.loading,
        ),
      );
    }

    final res = await getUserInterestsUseCase.call(
      pageNumber: state.page,
      perPage: 5,
      categoryName: state.currentCategoryName,
    );

    res.fold(
      (f) {
        refreshController.loadFailed();
        _mapFailureToState(emit, f, state);
      },
      (data) {
        final newList = [...state.categoriesInterests, ...data.interests];

        emit(
          state.copyWith(
            categoriesInterests: newList,
            page: state.page + 1,
            hasReachedEnd: !data.paginationData.hasMorePages,
            getCategoriesInterestsStatus: GetCategoriesInterestsStatus.success,
          ),
        );

        if (data.paginationData.hasMorePages) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      },
    );
  }

  void onLoadMore() {
    if (!state.hasReachedEnd) {
      fetchCategoriesInterests(isLoadMore: true);
    } else {
      refreshController.loadNoData();
    }
  }

  void onRefresh() async {
    emit(
      state.copyWith(page: 1, categoriesInterests: [], hasReachedEnd: false),
    );
    await fetchCategoriesInterests();
    refreshController.refreshCompleted();
  }

  void selectCategory(int index) {
    final newCategoyName = state.categoriesName[index];
    emit(
      state.copyWith(
        currentCategoryIndex: index,
        page: 1,
        selectedCategoryName: newCategoyName,
        hasReachedEnd: false,
      ),
    );
    fetchCategoriesInterests();
  }

  void setCurrentCategoryName(String categoryName) {
    emit(state.copyWith(selectedCategoryName: categoryName));
    //fetchCategoriesInterests();
  }

  void toggleInterest(int id) {
    final selected = [...state.selectedInterestIds];
    selected.contains(id) ? selected.remove(id) : selected.add(id);
    emit(state.copyWith(selectedInterestIds: selected.toSet()));
  }

  List<String> getSelectedInterestIds() =>
      state.selectedInterestIds.map((e) => e.toString()).toList();

  Future<void> submitInterests() async {
    emit(
      state.copyWith(completeInterestsStatus: CompleteInterestsStatus.loading),
    );
    final res = await completeInterestsUseCase.call(
      selectedIds: getSelectedInterestIds(),
    );
    res.fold((f) {
      _mapCompleteInterestsFailureToState(emit, f, state);
    }, (r) {
      emit(
        state.copyWith(
          completeInterestsStatus: CompleteInterestsStatus.success,
        ),
      );
    });
  }

  _mapFailureToState(emit, Failure f, InterestState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            getCategoriesInterestsStatus: GetCategoriesInterestsStatus.offline,
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            getCategoriesInterestsStatus: GetCategoriesInterestsStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

  _mapFailureCategoriesToState(emit, Failure f, InterestState state) {
    switch (f) {
      case OfflineFailure():
        emit(state.copyWith(getCategoriesStatus: GetCategoriesStatus.offline));

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            getCategoriesStatus: GetCategoriesStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

  _mapCompleteInterestsFailureToState(emit, Failure f, InterestState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            completeInterestsStatus: CompleteInterestsStatus.offline,
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            completeInterestsStatus: CompleteInterestsStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

  @override
  Future<void> close() {
    refreshController.dispose();
    return super.close();
  }
}
