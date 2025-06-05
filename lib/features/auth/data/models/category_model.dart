import 'package:sloopify_mobile/features/auth/data/models/interests_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/category_intity.dart';

class CategoryInterestsModel extends CategoryInterestsEntity {
  const CategoryInterestsModel({required super.categoryName, required super.interests});

  factory CategoryInterestsModel.fromJson(Map<String, dynamic> json) {
    return CategoryInterestsModel(
      categoryName: json['category']??"",
      interests: List.generate(
        json["interests"].length,
        (index) => InterestsModel.fromJson(json["interests"][index]),
      ),
    );
  }
}
