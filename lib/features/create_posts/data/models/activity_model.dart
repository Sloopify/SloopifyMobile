import 'package:sloopify_mobile/features/create_posts/domain/entities/activiity_entity.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    required super.name,
    required super.id,
    required super.status,
    required super.updatedAt,
    required super.createdAt,
    required super.mobileIcon,
    required super.category,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      name: json["name"] ?? "",
      id: json["id"] ?? 0,
      status: json["status"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      createdAt: json["createdAt"] ?? "",
      mobileIcon: json["mobileIcon"] ?? "",
      category: json["category"] ?? "",
    );
  }
}
