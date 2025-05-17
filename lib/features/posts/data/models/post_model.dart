import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.id,
    required super.content,
    required super.profileImage,
    required super.publisherName,
    required super.postDate,
    required super.numberOfComments,
    required super.numberOfLikes,
    super.feelings,
    super.friendsSharing,
    super.hashtags,
    super.hasPoll,
    super.images,
    super.location,
    super.polls,
    super.video,
    super.withEmotion,
  });
}
