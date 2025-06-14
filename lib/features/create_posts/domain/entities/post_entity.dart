import 'package:sloopify_mobile/core/managers/app_enums.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';

abstract class PostEntity{
  final PostType postType;
  final PostAudience postAudience;
  final List<int>? specificFriends;
  final List<int>? friendsExcept;

  PostEntity({required this.postAudience,required this.postType,this.specificFriends,this.friendsExcept});

  Map<String,dynamic> toJson();


}