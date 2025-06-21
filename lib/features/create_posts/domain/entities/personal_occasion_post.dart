import 'package:sloopify_mobile/core/managers/app_enums.dart';
import 'package:sloopify_mobile/core/utils/helper/app_extensions/post_audience_extention.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/personal_occasion.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/post_entity.dart';

class PersonalOccasionPost extends PostEntity {
  final PersonalOccasion personalOccasion;

  PersonalOccasionPost({
    required super.postAudience,
    required this.personalOccasion,
    super.friendsExcept,
    super.specificFriends,
  }):super(postType: PostType.personalOccasion);

  @override
  Future<Map<String, dynamic>> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  // @override
  // Map<String, dynamic> toJson() {
  //   return {
  //     "type": "personal_occasion",
  //     "privacy": postAudience.getValueForApi(),
  //     if (specificFriends != null) "specific_friends": specificFriends,
  //     if (friendsExcept != null) "friend_except": friendsExcept,
  //     "occasion": personalOccasion.toJson(),
  //   };
  // }
}
