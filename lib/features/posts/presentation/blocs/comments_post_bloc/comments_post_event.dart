part of 'comments_post_bloc.dart';

abstract class CommentsPostEvent extends Equatable {
  const CommentsPostEvent();
}
class GetCommentsForPost extends CommentsPostEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class LikeOrDisLikeComment extends CommentsPostEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}