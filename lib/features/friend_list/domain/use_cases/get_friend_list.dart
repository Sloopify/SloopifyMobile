import '../entities/friend.dart';
import '../repository/friend_list_repository.dart';

class GetFriendList {
  final FriendListRepository repository;

  GetFriendList(this.repository);

  Future<List<Friend>> call() {
    return repository.getFriendList(1, 4, "");
  }
}
