import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_list/domain/repository/friend_list_repository.dart';

import '../../domain/entities/friend.dart';

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
        avatarUrl: Image.asset("assets/images/friendlist/inbox.png"),
        isFriend: false,
      ),
    );
  }
}
