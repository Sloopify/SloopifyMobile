import '../../domain/entities/friend.dart';
import '../../domain/repositories/friend_list_repository.dart';
import '../models/friend_model.dart';

class FriendListRepositoryImpl implements FriendListRepository {
  @override
  Future<List<Friend>> getFriendList() async {
    // Replace this with actual API call or local data source
    await Future.delayed(const Duration(seconds: 1)); // simulate delay

    return List.generate(
      10,
      (index) => Friend(
        id: index.toString(),
        name: 'User $index',
        avatarUrl: 'https://via.placeholder.com/150',
        isFriend: false,
      ),
    );
  }
}
