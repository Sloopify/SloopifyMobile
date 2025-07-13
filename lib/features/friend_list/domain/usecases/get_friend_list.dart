import 'package:sloopify_mobile/features/friend_list/domain/repositories/friend_list_repository.dart';

import '../entities/friend.dart';

class GetFriendList {
  final FriendListRepository repository;

  GetFriendList(this.repository);

  Future<List<Friend>> call() async {
    return await repository.getFriendList();
  }
}
