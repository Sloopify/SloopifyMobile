import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../create_posts/domain/entities/feeling_result_entity.dart';
import '../../../create_posts/domain/entities/friends_result_entity.dart';

abstract class CreateStoryRepo{
  Future<Either<Failure, FriendsResultEntity>> getFriendsList({required int perPage,required int page});
  Future<Either<Failure, FriendsResultEntity>>  searchFriendsList({required String friendName,required int page,required int perPage});
  Future<Either<Failure, FeelingResultEntity>>  searchFeeling({required String feelingName,required int page,required int perPage});

  Future<Either<Failure,FeelingResultEntity>>  getFeelings({required int page,required int perPage});

}