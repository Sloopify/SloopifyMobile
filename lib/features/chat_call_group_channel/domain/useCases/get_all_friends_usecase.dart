import 'package:sloopify_mobile/features/chat_call_group_channel/domain/repositories/friend_repository.dart';
import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';

class GetAllFriendsUseCase {
  final FriendRepository repository;

  GetAllFriendsUseCase(this.repository);

  Future<List<Friend>> call() async {
    return await repository.getAllFriends();
  }
}
