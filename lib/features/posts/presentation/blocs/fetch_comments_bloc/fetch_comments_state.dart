import 'package:sloopify_mobile/features/posts/domain/entities/commet_entity.dart';

abstract class CommentFetchState {}

class CommentFetchInitial extends CommentFetchState {}

class CommentFetchLoading extends CommentFetchState {}

class CommentFetchSuccess extends CommentFetchState {
  final List<CommentEntity> comments;
  final bool hasMore;

  CommentFetchSuccess({required this.comments,required this.hasMore});
}

class CommentFetchFailure extends CommentFetchState {
  final String error;

  CommentFetchFailure({required this.error});
}