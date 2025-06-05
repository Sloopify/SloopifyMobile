import 'package:sloopify_mobile/features/auth/domain/entities/user_intresets_entity.dart';

class InterestsModel extends UserInterestsEntity {
  const InterestsModel({
    required super.name,
    required super.status,
    required super.id,
    required super.image,
  });

  factory InterestsModel.fromJson(Map<String, dynamic> json) {
    return InterestsModel(
      name: json["name"] ?? "",
      status: json["status"] ?? "",
      id: json["id"] ?? 0,
      image: json["image"] ?? "",
    );
  }
}
