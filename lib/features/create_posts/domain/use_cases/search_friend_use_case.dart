// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';

import '../../../../core/errors/failures.dart';

class SearchFriendsListUseCase {
  final CreatePostRepo createPostRepo;

  SearchFriendsListUseCase({required this.createPostRepo});

  Future<Either<Failure, List<UserEntity>>> call({
    required String friendName,
  }) async {
    final res = await createPostRepo.searchFriendsList(friendName: friendName);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
