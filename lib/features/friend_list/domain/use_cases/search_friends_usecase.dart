import 'package:sloopify_mobile/features/friend_list/domain/repository/friend_list_repository.dart';

import '../entities/friend.dart';

class SearchFriendsUseCase {
  final FriendListRepository repository;

  SearchFriendsUseCase(this.repository);

  Future<List<Friend>> call(String query, int page, int perPage, String token) {
    return repository.searchFriends(query, page, perPage, token);
  }
}
