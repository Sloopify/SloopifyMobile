import 'package:sloopify_mobile/core/utils/helper/app_extensions/post_audience_extention.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/poll_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/post_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/text_entity.dart';

import '../../../../core/managers/app_enums.dart';

class PollPost extends PostEntity {
  final String content;
  final bool disappears24h;
  final TextPropertyEntity textPropertyEntity;
  final PollEntity poll;

  PollPost(
      {required this.textPropertyEntity, required this.content, required this.disappears24h, required this.poll, required super.postAudience})
      :super(postType: PostType.poll);

  @override
  Future<Map<String, dynamic>> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }


  //
  // @override
  // Map<String, dynamic> toJson() {
  //   return {
  //     "type": "poll",
  //     "privacy": postAudience.getValueForApi(),
  //     if (specificFriends != null) "specific_friends": specificFriends,
  //     if (friendsExcept != null) "friend_except": friendsExcept,
  //     "poll": poll.toJson(),
  //   };
  // }

}