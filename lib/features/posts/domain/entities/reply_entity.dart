import 'package:equatable/equatable.dart';

class ReplyEntity extends Equatable {
  final String commentId;
  final String id;
  final String publisherName;
  final String publisherProfilePhoto;
  final String content;
  final String creationDate;
  final String numberOfLike;
  final bool isLiked;

  ReplyEntity({
    required this.creationDate,
    required this.numberOfLike,
    required this.publisherProfilePhoto,
    required this.publisherName,
    required this.content,
    required this.id,
    required this.commentId,
    required this.isLiked
  });

  @override
  // TODO: implement props
  List<Object?> get props => [commentId,id,publisherName,publisherProfilePhoto,content,creationDate,numberOfLike,isLiked];
}
