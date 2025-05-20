import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/commet_entity.dart';

import 'fetch_comments_event.dart';
import 'fetch_comments_state.dart';

class CommentFetchBloc extends Bloc<CommentFetchEvent, CommentFetchState> {
  final int pageSize;
  int currentPage = 1;
  bool hasMore = true;
  List<CommentEntity> _comments = [];

  CommentFetchBloc({this.pageSize = 10}) : super(CommentFetchInitial()) {
    on<FetchInitialComments>(_onFetchInitial);
    on<FetchMoreComments>(_onFetchMore);
  }

  Future<void> _onFetchInitial(
    FetchInitialComments event,
    Emitter<CommentFetchState> emit,
  ) async {
    emit(CommentFetchLoading());
    try {
      currentPage = 1;
      final newComments = await fetchCommentsFromServer(page: currentPage);
      _comments = newComments;
      hasMore = newComments.length == pageSize;
      emit(CommentFetchSuccess(comments: _comments, hasMore: hasMore));
    } catch (e) {
      emit(CommentFetchFailure(error: e.toString()));
    }
  }

  Future<void> _onFetchMore(
    FetchMoreComments event,
    Emitter<CommentFetchState> emit,
  ) async {
    if (!hasMore || state is CommentFetchLoading) return;

    emit(
      CommentFetchSuccess(comments: _comments, hasMore: hasMore),
    ); // keep previous state

    try {
      currentPage++;
      final newComments = await fetchCommentsFromServer(page: currentPage);
      _comments.addAll(newComments);
      hasMore = newComments.length > pageSize;
      emit(CommentFetchSuccess(comments: _comments, hasMore: hasMore));
    } catch (e) {
      emit(CommentFetchFailure(error: e.toString()));
    }
  }

  Future<List<CommentEntity>> fetchCommentsFromServer({
    required int page,
  }) async {
    // Mock or real API call here
    await Future.delayed(Duration(milliseconds: 500));
    return List.generate(10, (index) {
      final id = 'c_${page}_$index';
      return CommentEntity(
        id: id,
        content:
            'Lorem ipsum non orci tincidunt sem dignissim sed est sed vel ac cras viverra interdum dignissim aenean tortor viverra integer.',
        publisherName: 'User $id',
        publisherProfilePhoto: AssetsManager.manExample,
        postId: '1',
        creationDate: '',
        isLiked: false,
        numberOfLike: 10,
        replies: [
          CommentEntity(
            postId: "1",
            publisherName: "Nour",
            id: 'reply1',
            content:
                "Lorem ipsum non orci tincidunt sem dignissim sed est sed vel ac cras viverra interdum dignissim aenean tortor viverra integer.",
            creationDate: "",
            numberOfLike: 15,
            publisherProfilePhoto: AssetsManager.manExample,
            replies: [],
            isLiked: false,
          ),
        ],
      );
    });
  }
}
