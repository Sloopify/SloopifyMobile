import 'package:sloopify_mobile/features/create_posts/data/models/activity_model.dart';

import '../../../auth/data/models/pagination_data_model.dart';
import '../../domain/entities/categories_activity_entity.dart';

class CategoriesActivityResultModel extends ActivityCategoriesResult{
  const CategoriesActivityResultModel({required super.paginationData, required super.categories});
  factory CategoriesActivityResultModel.fromJson(Map<String, dynamic> json) {
    final categories = json["categories"] as List;


    return CategoriesActivityResultModel(
      paginationData: PaginationDataModel.fromJson(json["pagination"]),
      categories:categories,
    );
  }

}