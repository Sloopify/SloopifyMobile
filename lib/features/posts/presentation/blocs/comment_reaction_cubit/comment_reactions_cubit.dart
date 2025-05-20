import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/commet_entity.dart';

class CommentInteractionCubit extends Cubit<List<CommentEntity>> {
  CommentInteractionCubit() : super([]);

  void setInitialComments(List<CommentEntity> comments) {
    emit(List.from(comments));
  }

  void toggleLike(String commentId) {
    final updated = state.map((comment) {
      if (comment.id == commentId) {
        return comment.copyWith(
          isLiked: !comment.isLiked,
          numberOfLike: comment.isLiked
              ? comment.numberOfLike - 1
              : comment.numberOfLike + 1,
        );
      }
      return comment;
    }).toList();
    emit(updated);
  }

  void addReply(String parentId, CommentEntity reply) {
    final updated = state.map((comment) {
      if (comment.id == parentId) {
        final replies = List<CommentEntity>.from(comment.replies)..add(reply);
        return comment.copyWith(replies: replies);
      }
      return comment;
    }).toList();
    emit(updated);
  }
}