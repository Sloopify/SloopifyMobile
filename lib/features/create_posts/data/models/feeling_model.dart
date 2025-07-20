import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';

class FeelingModel extends FeelingEntity {
  const FeelingModel({
    required super.name,
    required super.id,
    required super.status,
    required super.updatedAt,
    required super.createdAt,
    required super.mobileIcon,
  });

  factory FeelingModel.fromJson(Map<String, dynamic> json) {
    return FeelingModel(
      name: json["name"] ?? "",
      id: json["id"] ?? 0,
      status: json["status"] ?? "",
      updatedAt: json["updatedAt"]??"",
      createdAt: json["createdAt"]??"",
      mobileIcon: json["mobileIcon"]??"",
    );
  }
}
