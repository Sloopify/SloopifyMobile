import 'package:equatable/equatable.dart';

enum CommentLikeStatus { init, success, error, offline, loading }

enum ReplyStatus { init, success, error, offline, loading }

class CommentReactionsState extends Equatable {
  final bool isLiked;
  final CommentLikeStatus commentLikeStatus;
  final ReplyStatus replyStatus;

  CommentReactionsState({
    required this.replyStatus,
    required this.commentLikeStatus,
    required this.isLiked,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isLiked, commentLikeStatus, replyStatus];

  factory CommentReactionsState.empty() {
    return CommentReactionsState(
      replyStatus: ReplyStatus.init,
      commentLikeStatus: CommentLikeStatus.init,
      isLiked: false,
    );
  }

  CommentReactionsState copyWith({
    ReplyStatus? replyStatus,
    CommentLikeStatus? commentLikeStatus,
    bool? isLiked,
  }) {
    return CommentReactionsState(
      replyStatus: replyStatus ?? this.replyStatus,
      commentLikeStatus: commentLikeStatus ?? this.commentLikeStatus,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
