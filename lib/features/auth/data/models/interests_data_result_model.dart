import 'package:sloopify_mobile/features/auth/data/models/pagination_data_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/interets_data_result.dart';

import 'interests_model.dart';

class InterestsDataResultModel extends InterestsDataResult {
  InterestsDataResultModel({
    required super.paginationData,
    required super.interests,
  });

  factory InterestsDataResultModel.fromJson(Map<String, dynamic> json) {
    final interestsList = json["interests"] as List;
    final innerInterests = interestsList.isNotEmpty
        ? interestsList[0]["interests"] as List
        : [];

    return InterestsDataResultModel(
      paginationData: PaginationDataModel.fromJson(json["pagination"]),
      interests: innerInterests.map((e) => InterestsModel.fromJson(e)).toList(),
    );
  }
}
