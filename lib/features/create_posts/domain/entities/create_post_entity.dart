import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/selected_file_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/frined_entity.dart';

class CreatePostEntity extends Equatable {
  final String text;
  final List<FriendEntity> friends;
  final List<FriendEntity> mentions;
  final AssetEntity? assetEntity;
  final String feelings;
  final bool is24Hours;
  final double latitude;
  final double longtitude;
  final List<File> images;
  final List<File> videos;
  final List<String> activities;
  final PostAudience postAudience;

  CreatePostEntity({
    required this.text,
    required this.feelings,
    required this.is24Hours,
    required this.images,
    required this.videos,
    required this.friends,
    required this.mentions,
    required this.latitude,
    required this.longtitude,
    required this.activities,
    required this.postAudience,
    required this.assetEntity
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    text,
    feelings,
    is24Hours,
    images,
    videos,
    friends,
    mentions,
    latitude,
    longtitude,
    activities,
    postAudience,
    assetEntity
  ];

  factory CreatePostEntity.fromEmpty() {
    return CreatePostEntity(
      text: "",
      feelings: "",
      is24Hours: false,
      images: [],
      videos: [],
      friends: [],
      mentions: [],
      latitude: 0.0,
      longtitude: 0.0,
      activities: [],
      postAudience: PostAudience.public,
      assetEntity: null
    );
  }

  CreatePostEntity copyWith({
    String? text,
    String? feelings,
    bool? is24Hours,
    List<File>? images,
    List<File>? videos,
    List<FriendEntity>? friends,
    List<FriendEntity>? mentions,
    double? latitude,
    double? longtitude,
    List<String>? activities,
    PostAudience ?postAudience,
    AssetEntity ? assetEntity
  }) {
    return CreatePostEntity(
      postAudience: postAudience??this.postAudience,
      text: text ?? this.text,
      feelings: feelings ?? this.feelings,
      is24Hours: is24Hours ?? this.is24Hours,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      friends: friends ?? this.friends,
      mentions: mentions ?? this.mentions,
      latitude: latitude ?? this.latitude,
      longtitude: longtitude ?? this.longtitude,
      activities: activities ?? this.activities,
      assetEntity: assetEntity??this.assetEntity
    );
  }
}
