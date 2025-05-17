import 'package:sloopify_mobile/features/posts/domain/entities/reply_entity.dart';

class ReplyModel extends ReplyEntity {
  ReplyModel({
    required super.creationDate,
    required super.numberOfLike,
    required super.publisherProfilePhoto,
    required super.publisherName,
    required super.content,
    required super.id,
    required super.commentId, required super.isLiked,
  });
}
