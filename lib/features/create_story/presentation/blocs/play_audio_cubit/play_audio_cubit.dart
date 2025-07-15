import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/audio_entity.dart';
import 'package:sloopify_mobile/features/create_story/domain/use_cases/get_story_audios_use_case.dart';
import 'package:sloopify_mobile/features/create_story/domain/use_cases/search_story_audio_use_case.dart';

import '../../../../../core/errors/failures.dart';

part 'play_audio_state.dart';

class PlayAudioCubit extends Cubit<PlayAudioState> {
  final GetStoryAudiosUseCase getStoryAudiosUseCase;
  final SearchStoryAudioUseCase searchStoryAudioUseCase;

  PlayAudioCubit({
    required this.searchStoryAudioUseCase,
    required this.getStoryAudiosUseCase,
  }) : super(PlayAudioState.fromEmpty());
  final RefreshController refreshController = RefreshController();

  setAudioId(int value) {
    emit(
      state.copyWith(
        selectedAudioId: value,
        getAudioStatus: GetAudioStatus.init,
      ),
    );
  }

  setAudioUrl(String value) {
    emit(
      state.copyWith(
        selectedAudioUrl: value,
        getAudioStatus: GetAudioStatus.init,
      ),
    );
  }
  setSearchKeyWord(String value) {
    emit(
      state.copyWith(
        searchKeyWord: value,
        getAudioStatus: GetAudioStatus.loading,
      ),
    );
  }
  setAudioImage(String value) {
    emit(
      state.copyWith(
        selectedAudioImage: value,
        getAudioStatus: GetAudioStatus.init,
      ),
    );
  }

  setAudioName(String value) {
    emit(
      state.copyWith(
        selectedAudioName: value,
        getAudioStatus: GetAudioStatus.init,
      ),
    );
  }

  getAllAudios({bool isLoadMore = false}) async {
    if (state.getAudioStatus == GetAudioStatus.loading) return;
    if (!isLoadMore) {
      emit(
        state.copyWith(
          page: 1,
          hasReachedEnd: false,
          audioFiles: [],
          getAudioStatus: GetAudioStatus.loading,
        ),
      );
    }
    final res = await getStoryAudiosUseCase.call(page: state.page, perPage: 10);
    res.fold(
      (l) {
        refreshController.loadFailed();
        _mapFailureGetAudiosToState(emit, l, state);
      },
      (data) {
        final newList = [...state.audioFiles, ...data.audios];

        emit(
          state.copyWith(
            audioFiles: newList,
            page: state.page + 1,
            hasReachedEnd: !data.paginationData.hasMorePages,
            getAudioStatus: GetAudioStatus.success,
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
      state.searchKeyWord.isEmpty
          ? getAllAudios(isLoadMore: true)
          : searchAudios(isLoadMore: true);
    } else {
      refreshController.loadNoData();
    }
  }

  void onRefresh() async {
    emit(state.copyWith(page: 1, audioFiles: [], hasReachedEnd: false));
    state.searchKeyWord.isEmpty ? getAllAudios() : searchAudios();
    refreshController.refreshCompleted();
  }

  searchAudios({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      emit(
        state.copyWith(
          page: 1,
          hasReachedEnd: false,
          selectedAudioUrl: '',
          audioFiles: [],
          getAudioStatus: GetAudioStatus.loading,
        ),
      );
    }
    final res = await searchStoryAudioUseCase.call(
      name: state.searchKeyWord,
      page: state.page,
      perPage: 10,
    );
    res.fold(
      (l) {
        _mapFailureGetAudiosToState(emit, l, state);
        refreshController.loadFailed();
      },
      (data) {
        final newList = [...state.audioFiles, ...data.audios];

        emit(
          state.copyWith(
            audioFiles: newList,
            page: state.page + 1,
            hasReachedEnd: !data.paginationData.hasMorePages,
            getAudioStatus: GetAudioStatus.success,
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

  _mapFailureGetAudiosToState(emit, Failure f, PlayAudioState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            getAudioStatus: GetAudioStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            getAudioStatus: GetAudioStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}
