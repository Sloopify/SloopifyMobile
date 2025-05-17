import 'package:sloopify_mobile/features/posts/domain/entities/commet_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.postId,
    required super.publisherName,
    required super.id,
    required super.content,
    required super.creationDate,
    required super.numberOfLike,
    required super.publisherProfilePhoto, required super.replies, required super.isLiked,
  });
}
