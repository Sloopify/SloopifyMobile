import 'package:sloopify_mobile/features/create_posts/data/models/feeling_model.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_result_entity.dart';

import '../../../auth/data/models/pagination_data_model.dart';

class FeelingsResultModel extends FeelingResultEntity{
  FeelingsResultModel({required super.paginationData, required super.feelings});
  factory FeelingsResultModel.fromJson(Map<String, dynamic> json) {
    final feelings = json["feelings"] as List;

    return FeelingsResultModel(
      paginationData: PaginationDataModel.fromJson(json["pagination"]),
      feelings: feelings.map((e) => FeelingModel.fromJson(e)).toList(),
    );
  }

}