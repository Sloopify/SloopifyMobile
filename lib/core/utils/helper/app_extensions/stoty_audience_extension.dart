import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_audience/choose_story_audience.dart';

extension StoryAudienceExtension on StoryAudience {
  String getText() {
    switch (this) {
      case StoryAudience.public:
        return "public";
      case StoryAudience.friends:
        return "Friends";
      case StoryAudience.friendsExcept:
        return "Friends except";
      case StoryAudience.specificFriends:
        return "Specific friends";
    }

  }
  String getSvg() {
    switch (this) {
      case StoryAudience.public:
        return AssetsManager.postPublic;
      case StoryAudience.friends:
        return AssetsManager.postFriends;
      case StoryAudience.friendsExcept:
        return AssetsManager.friendsExcept;
      case StoryAudience.specificFriends:
        return AssetsManager.specificFriend;
    }

  }
  String getDescription() {
    switch (this) {
      case StoryAudience.public:
        return "Anyone on or off application";
      case StoryAudience.friends:
        return "Your friends on application";
      case StoryAudience.friendsExcept:
        return "Don’t show to some friends";
      case StoryAudience.specificFriends:
        return "show for specific friends";

    }

  }
  String getValueForApi() {
    switch (this) {
      case StoryAudience.public:
        return "public";
      case StoryAudience.friends:
        return "friends";
      case StoryAudience.friendsExcept:
        return "friend_except";
      case StoryAudience.specificFriends:
        return "specific_friends";
    }
  }
}