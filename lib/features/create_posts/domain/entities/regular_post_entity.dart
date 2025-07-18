import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sloopify_mobile/core/managers/app_enums.dart';
import 'package:sloopify_mobile/core/utils/helper/app_extensions/post_audience_extention.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/mention_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/post_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/text_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';

class RegularPostEntity extends PostEntity {
  final String content;
  final TextPropertyEntity textPropertyEntity;
  final List<String>? backGroundColor;
  final bool disappears24h;
  final MentionEntity? mention;
  final List<MediaEntity>? mediaFiles;

  RegularPostEntity({
    required super.postAudience,
    super.friendsExcept,
    super.specificFriends,
    required this.content,
    this.mention,
    required this.textPropertyEntity,
    required this.disappears24h,
    this.backGroundColor,
    this.mediaFiles,
  }) : super(postType: PostType.regular);

  RegularPostEntity copyWith({
    String? content,
    bool? isBold,
    bool? isItalic,
    bool? isUnderLine,
    String? color,
    List<int>? friends,
    int? placeId,
    String? activity,
    String? feeling,
    List<String>? backGroundColor,
    bool? disappears24h,
    PostAudience? postAudience,
    List<int>? friendsExcept,
    List<int>? specificFriends,
    List<MediaEntity>? updatedMediaFiles,

  }) {
    return RegularPostEntity(
      specificFriends: specificFriends ?? this.specificFriends,
      postAudience: postAudience ?? this.postAudience,
      backGroundColor: backGroundColor ?? this.backGroundColor,
      friendsExcept: friendsExcept ?? this.friendsExcept,
      mediaFiles: updatedMediaFiles ?? mediaFiles,
      mention:mention?.copyWith(
        placeId: placeId ?? mention?.placeId,
        feeling: feeling ?? mention?.feeling,
        activity: activity ?? mention?.activity,
        friends: friends ?? mention?.friends,
      ),
      content: content ?? this.content,
      textPropertyEntity: textPropertyEntity.copyWith(
        color: color ?? textPropertyEntity.color,
        isBold: isBold ?? textPropertyEntity.isBold,
        isItalic: isItalic ?? textPropertyEntity.isItalic,
        isUnderLine: isUnderLine ?? textPropertyEntity.isUnderLine,
      ),
      disappears24h: disappears24h ?? this.disappears24h,
    );
  }


  factory RegularPostEntity.empty(){
    return RegularPostEntity(postAudience: PostAudience.public,
        content: "",
        textPropertyEntity: TextPropertyEntity.empty(),
        specificFriends: null,
        mention: MentionEntity(),
        mediaFiles: null,
        friendsExcept: null,
        backGroundColor: null,
        disappears24h: false);
  }

  @override
  Future<Map<String, dynamic>> toJson() async {
    print(backGroundColor);
    final Map<String, dynamic> data = {
      'type': 'regular',
      'content': content,
      'privacy': postAudience.getValueForApi(),
      'disappears_24h': mediaFiles!=null && mediaFiles!.isNotEmpty? boolToInt(disappears24h): disappears24h,
      'text_properties': textPropertyEntity.toJson(withMedia: mediaFiles!=null && mediaFiles!.isNotEmpty),
    };

    if (backGroundColor != null ) {
      if(mediaFiles==null || mediaFiles!.isEmpty) {
        data['background_color'] = backGroundColor!.toList();
      }else{
        // List<String> colors= backGroundColor!;
        // for(int i=0;i<colors.length;i++){
        //   data["background_color[$i]"]=colors[i];
        // }
      }
    }

    if (mention != null) {
      data['mentions'] = mention!.toJson(mediaFiles!=null &&mediaFiles!.isNotEmpty);
    }

    if (friendsExcept != null) {
      if(mediaFiles==null || mediaFiles!.isEmpty) {
        data['friend_except'] =friendsExcept;
      }else{
        List<int> friendsExceptList= friendsExcept!;
        for(int i=0;i<friendsExceptList.length;i++){
          data["friend_except[$i]"]=friendsExceptList[i];
        }
      }
    }

    if (specificFriends != null) {
      if(mediaFiles==null || mediaFiles!.isEmpty) {
        data['specific_friends'] =specificFriends;
      }else{
        List<int> specificFriendsList= specificFriends!;
        for(int i=0;i<specificFriendsList.length;i++){
          data["specific_friends[$i]"]=specificFriendsList[i];
        }
      }
    }

    if (mediaFiles != null) {
      // Wait for all media files to be converted to JSON
      final mediaList = await Future.wait(mediaFiles!.map((e) => e.toJson()));
      data['media'] = mediaList;
    }
    return data;
  }

  int boolToInt(bool? value) => (value ?? false) ? 1 : 0;

}
