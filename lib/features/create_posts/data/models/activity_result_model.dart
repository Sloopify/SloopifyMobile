import 'package:sloopify_mobile/features/create_posts/data/models/activity_model.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/activity_result_entity.dart';

import '../../../auth/data/models/pagination_data_model.dart';

class ActivityResultModel extends ActivityResultEntity{
  ActivityResultModel({required super.paginationData, required super.activities});
  factory ActivityResultModel.fromJson(Map<String, dynamic> json) {
    final activities = json["activities"] as List;

    return ActivityResultModel(
      paginationData: PaginationDataModel.fromJson(json["pagination"]),
      activities: activities.map((e) => ActivityModel.fromJson(e)).toList(),
    );
  }

}