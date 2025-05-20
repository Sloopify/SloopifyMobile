import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/reply_entity.dart';

class CommentEntity extends Equatable {
  final String postId;
  final String id;
  final String publisherName;
  final String publisherProfilePhoto;
  final String content;
  final String creationDate;
  final int numberOfLike;
  final bool isLiked;
  final List<CommentEntity> replies;

  CommentEntity({
    required this.postId,
    required this.publisherName,
    required this.id,
    required this.content,
    required this.creationDate,
    required this.numberOfLike,
    required this.publisherProfilePhoto,
    required this.replies,
    required this.isLiked,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    publisherName,
    publisherProfilePhoto,
    content,
    numberOfLike,
    creationDate,
    postId,
    replies,
    isLiked,
  ];

  factory CommentEntity.empty() {
    return CommentEntity(
      postId: "",
      publisherName: "",
      id: "",
      content: "",
      creationDate: "",
      numberOfLike: 0,
      publisherProfilePhoto: "",
      replies: [],
      isLiked: false,
    );
  }

  CommentEntity copyWith({
    String? postId,
    String? id,
    String? publisherName,
    String? publisherProfilePhoto,
    String? content,
    String? creationDate,
    int? numberOfLike,
    bool? isLiked,
    List<CommentEntity>? replies,
  }) {
    return CommentEntity(
      postId: postId ?? this.postId,
      publisherName: publisherName ?? this.publisherName,
      id: id ?? this.id,
      content: content ?? this.content,
      creationDate: creationDate ?? this.creationDate,
      numberOfLike: numberOfLike ?? this.numberOfLike,
      publisherProfilePhoto:
          publisherProfilePhoto ?? this.publisherProfilePhoto,
      replies: replies ?? this.replies,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
