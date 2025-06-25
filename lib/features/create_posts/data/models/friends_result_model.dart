import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/data/models/user_model.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/friends_result_entity.dart';

import '../../../auth/data/models/pagination_data_model.dart';

class FriendsResultModel extends FriendsResultEntity{
  FriendsResultModel({required super.paginationData, required super.friends});
  factory FriendsResultModel.fromJson(Map<String, dynamic> json) {
    final friendsList = json["friends"] as List;


    return FriendsResultModel(
      paginationData: PaginationDataModel.fromJson(json["pagination"]),
      friends: friendsList.map((e) => UserModel.fromJson(e)).toList(),
    );
  }

}