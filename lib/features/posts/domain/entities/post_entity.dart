import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_poll_entity.dart';

class PostEntity extends Equatable {
  final String id;
  final String content;
  final String profileImage;
  final List<String>? hashtags;
  final String postDate;
  final String publisherName;
  final List<String>? images;
  final String? location;
  final String? video;
  final bool? hasPoll;
  final PostPollEntity? polls;
  final int numberOfLikes;
  final int numberOfComments;
  final bool? withEmotion;
  final String? feelings;
  final List<String>? friendsSharing;

  PostEntity({
    required this.id,
    required this.content,
    required this.profileImage,
    required this.publisherName,
    this.hashtags,
    required this.postDate,
    this.images,
    this.location,
    this.video,
    this.polls,
    required this.numberOfComments,
    required this.numberOfLikes,
    this.feelings,
    this.friendsSharing,
    this.hasPoll,
    this.withEmotion,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    hasPoll,
    withEmotion,
    friendsSharing,
    feelings,
    numberOfLikes,
    numberOfComments,
    polls,
    video,
    location,
  ];
}
