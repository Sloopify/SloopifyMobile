import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';

extension PostAudienceExtention on PostAudience {
  String getText() {
    switch (this) {
      case PostAudience.public:
        return "public";
      case PostAudience.friends:
        return "Friends";
      case PostAudience.friendsExcept:
        return "Friends except";
      case PostAudience.specificFriends:
        return "Specific friends";
      case PostAudience.onlyMe:
        return "Only me";
    }

  }
  String getSvg() {
    switch (this) {
      case PostAudience.public:
        return AssetsManager.postPublic;
      case PostAudience.friends:
        return AssetsManager.postFriends;
      case PostAudience.friendsExcept:
        return AssetsManager.friendsExcept;
      case PostAudience.specificFriends:
        return AssetsManager.specificFriend;
      case PostAudience.onlyMe:
        return AssetsManager.onlyMe;
    }

  }
  String getDescription() {
    switch (this) {
      case PostAudience.public:
        return "Anyone on or off application";
      case PostAudience.friends:
        return "Your friends on application";
      case PostAudience.friendsExcept:
        return "Don’t show to some friends";
      case PostAudience.specificFriends:
        return "show for specific friends";
      case PostAudience.onlyMe:
        return "";
    }

  }
  String getValueForApi() {
    switch (this) {
      case PostAudience.public:
        return "public";
      case PostAudience.friends:
        return "friends";
      case PostAudience.friendsExcept:
        return "friend_except";
      case PostAudience.specificFriends:
        return "specific_friends";
      case PostAudience.onlyMe:
        return "only_me";
    }
  }
}